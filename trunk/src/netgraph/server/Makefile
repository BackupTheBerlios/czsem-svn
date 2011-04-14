#
# Standard makefile for unix
#
# Makefile for Netgraph server
#
CC=g++
CF=
# knihovna pcre na MacOS je v /opt/local:
LIBS=/opt/local/lib
HEADERS=/opt/local/include

all: dotser netser

clean:
	rm -f *.o
	rm -f core
	rm -f *.bak
	rm -f *~

mrproper:
	rm -f *.o
	rm -f core
	rm -f *.bak
	rm -f *~
	rm -f dotser
	rm -f netser
	rm -f dotser.exe
	rm -f netser.exe

passwd.o: passwd.h passwd.c
	$(CC) $(CF) -I$(HEADERS) -c $*.c

mutual.o: mutual.h mutual.c
	$(CC) $(CF) -I$(HEADERS) -c $*.c

trees.o: trees.h trees.c
	$(CC) $(CF) -I$(HEADERS) -c $*.c

searching.o: searching.h searching.c
	$(CC) $(CF) -I$(HEADERS) -c $*.c

matching.o: matching.h matching.c
	$(CC) $(CF) -I$(HEADERS) -c $*.c

messages.o: messages.h messages.c
	$(CC) $(CF) -I$(HEADERS) -c $*.c

dotser.o: messages.h matching.h searching.h trees.h loadsave.h mutual.h define.h passwd.h dotser.c
	$(CC) $(CF) -I$(HEADERS) -c $*.c

dotser: messages.o matching.o searching.o trees.o mutual.o passwd.o loadsave.o dotser.o
	$(CC) $(CF) dotser.o matching.o trees.o -L$(LIBS) -lpcre messages.o searching.o loadsave.o passwd.o mutual.o -o dotser

loadsave.o: loadsave.cpp loadsave.h trees.h define.h
	$(CC) $(CF) -I$(HEADERS) -c $*.cpp

netser.o: passwd.h mutual.h netser.c
	$(CC) $(CF) -I$(HEADERS) -c $*.c

netser: passwd.o mutual.o netser.o
	$(CC) $(CF) netser.o -L$(LIBS) -lpcre passwd.o mutual.o -o netser

#
# end of the makefile
#

