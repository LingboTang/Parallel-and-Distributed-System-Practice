# Compiler

CC := gcc

# Compile Options

CCOPTS := -Wall -std=gnu99 -O2 -g

# Thread Linker
LP := -lpthread

# Object File and Source File
UTILC := myutils.c
UTILH := myutils.h
UTILO := myutils.o
PSRSC := psrs.c
PSRSO := psrs.o
EXEC := psrs

# Run Time
run:	clean
	make build
	./$(EXEC) 2000000

# Build all files
build:	$(PSRSO) $(UTILO)
	$(CC) $(CCOPTS) -o $(EXEC) $(PSRSO) $(UTILO) $(LP)

# Build Main file
$(PSRSO):	$(PSRSC) 
	$(CC) $(CCOPTS) -c $(PSRSC)

# Build Util functions
$(UTILO):	$(UTILC) $(UTILH)
	$(CC) $(CCOPTS) -c $(UTILC)

# Clean Up
clean:
	rm -rf core a.out psrs *~ *.o
