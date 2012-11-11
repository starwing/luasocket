-----------------------------------------------------------------------------
-- MIME support for the Lua language.
-- Author: Diego Nehab
-- Conforming to RFCs 2045-2049
-- RCS ID: $Id$
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Declare module and import dependencies
-----------------------------------------------------------------------------
local ltn12 = require "ltn12"
local mime  = require "mime.core"
local M = {}

-- encode, decode and wrap algorithm tables
local encodet = {}
local decodet = {}
local wrapt = {}

-- creates a function that chooses a filter by name from a given table
local function choose(table)
    return function(name, opt1, opt2)
        if type(name) ~= "string" then
            name, opt1, opt2 = "default", name, opt1
        end
        local f = table[name or "nil"]
        if not f then 
            error("unknown key (" .. tostring(name) .. ")", 3)
        else return f(opt1, opt2) end
    end
end

-- define the encoding filters
encodet['base64'] = function()
    return ltn12.filter.cycle(b64, "")
end

encodet['quoted-printable'] = function(mode)
    return ltn12.filter.cycle(qp, "",
        (mode == "binary") and "=0D=0A" or "\r\n")
end

-- define the decoding filters
decodet['base64'] = function()
    return ltn12.filter.cycle(unb64, "")
end

decodet['quoted-printable'] = function()
    return ltn12.filter.cycle(unqp, "")
end

local function format(chunk)
    if chunk then
        if chunk == "" then return "''"
        else return string.len(chunk) end
    else return "nil" end
end

-- define the line-wrap filters
wrapt['text'] = function(length)
    length = length or 76
    return ltn12.filter.cycle(wrp, length, length)
end
wrapt['base64'] = wrapt['text']
wrapt['default'] = wrapt['text']

wrapt['quoted-printable'] = function()
    return ltn12.filter.cycle(qpwrp, 76, 76)
end

M.encodet = encodet
M.decodet = decodet
M.wrapt = wrapt

-- function that choose the encoding, decoding or wrap algorithm
M.encode = choose(encodet)
M.decode = choose(decodet)
M.wrap = choose(wrapt)

-- define the end-of-line normalization filter
function M.normalize(marker)
    return ltn12.filter.cycle(eol, 0, marker)
end

-- high level stuffing filter
function M.stuff()
    return ltn12.filter.cycle(dot, 2)
end

return M
