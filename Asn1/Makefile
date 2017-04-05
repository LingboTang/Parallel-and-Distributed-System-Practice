# Compiler

CC := gcc

# Compile Options

CCOPTS := -Wall -std=gnu99 -O1 -g

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
	./$(EXEC) 2000000 8
	./$(EXEC) 4000000 8
	./$(EXEC) 8000000 8
	./$(EXEC) 16000000 8
	./$(EXEC) 32000000 8
	./$(EXEC) 64000000 8
	./$(EXEC) 128000000 8
	./$(EXEC) 256000000 8
	./$(EXEC) 512000000 8

# Build all files
build:	$(PSRSO) $(UTILO)
	$(CC) $(CCOPTS) -o $(EXEC) $(PSRSO) $(UTILO) $(LP)

# Build Main file
$(PSRSO):	$(PSRSC) 
	$(CC) $(CCOPTS) -c $(PSRSC)

# Build Util functions
$(UTILO):	$(UTILC) $(UTILH)
	$(CC) $(CCOPTS) -c $(UTILC)

#debugging:
memcheck:
	valgrind --leak-check=full ./$(EXEC) 80000000 8	

# Clean Up
clean:
	rm -rf core a.out psrs *~ *.o
