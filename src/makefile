#------
# Load configuration
#
include ../config

#------
# Hopefully no need to change anything below this line
#

#------
# Modules belonging to socket-core
#

#$(COMPAT)/compat-5.1.o \

SOCKET_OBJS:= \
	luasocket.o \
	timeout.o \
	buffer.o \
	io.o \
	auxiliar.o \
	options.o \
	inet.o \
	tcp.o \
	udp.o \
	except.o \
	select.o \
	wsocket.o \
	#usocket.o 

#------
# Modules belonging mime-core
#
#$(COMPAT)/compat-5.1.o \

MIME_OBJS:=\
	mime.o 

#------
# Modules belonging unix (local domain sockets)
#
UNIX_OBJS:=\
	buffer.o \
	auxiliar.o \
	options.o \
	timeout.o \
	io.o \
	usocket.o \
	unix.o

#------
# Modules belonging to serial (device streams)
#
SERIAL_OBJS:=\
	buffer.o \
	auxiliar.o \
	timeout.o \
	io.o \
	usocket.o \
	serial.o

all: $(SOCKET_SO) $(MIME_SO) 

$(SOCKET_SO): $(SOCKET_OBJS)
	$(LD) -o $@ $(SOCKET_OBJS) $(LDFLAGS)

$(MIME_SO): $(MIME_OBJS)
	$(LD) -o $@ $(MIME_OBJS) $(LDFLAGS)

all-unix: all $(UNIX_SO) $(SERIAL_SO)

$(UNIX_SO): $(UNIX_OBJS)
	$(LD) $(LDFLAGS) -o $@ $(UNIX_OBJS)

$(SERIAL_SO): $(SERIAL_OBJS)
	$(LD) $(LDFLAGS) -o $@ $(SERIAL_OBJS)

#------
# List of dependencies
#
auxiliar.o: auxiliar.c auxiliar.h
buffer.o: buffer.c buffer.h io.h timeout.h
except.o: except.c except.h
inet.o: inet.c inet.h socket.h io.h timeout.h usocket.h
io.o: io.c io.h timeout.h
luasocket.o: luasocket.c luasocket.h auxiliar.h except.h timeout.h \
  buffer.h io.h inet.h socket.h usocket.h tcp.h udp.h select.h
mime.o: mime.c mime.h
options.o: options.c auxiliar.h options.h socket.h io.h timeout.h \
  usocket.h inet.h
select.o: select.c socket.h io.h timeout.h usocket.h select.h
serial.o: serial.c auxiliar.h socket.h io.h timeout.h usocket.h \
  unix.h buffer.h
tcp.o: tcp.c auxiliar.h socket.h io.h timeout.h usocket.h inet.h \
  options.h tcp.h buffer.h
timeout.o: timeout.c auxiliar.h timeout.h
udp.o: udp.c auxiliar.h socket.h io.h timeout.h usocket.h inet.h \
  options.h udp.h
unix.o: unix.c auxiliar.h socket.h io.h timeout.h usocket.h options.h \
  unix.h buffer.h
usocket.o: usocket.c socket.h io.h timeout.h usocket.h

clean:
	rm -f $(SOCKET_SO) $(SOCKET_OBJS) 
	rm -f $(MIME_SO) $(UNIX_SO) $(MIME_OBJS) $(UNIX_OBJS)

#------
# End of makefile configuration
#
