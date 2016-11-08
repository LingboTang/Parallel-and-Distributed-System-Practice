run:build
	mpirun -np 3 mypsrs 36 output.txt
build: clean
	mpicc -O2 -w -o mypsrs my_psrs.c -pthread -g


kway.o: kway.c kway.h
		mpicc -c kway.c -o kway.o
debug.o: debug.c debug.h
		mpicc -c debug.c -o debug.o

submit:
	git add -A .
clean:
	rm -rf core a.out mypsrs output.txt *~