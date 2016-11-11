run:build
	mpirun -np 2 mypsrs 32000000 output.txt
build: clean
	mpicc -std=gnu99 -O2 -w -o mypsrs my_psrs.c -pthread -g

qsort: clean
	gcc -std=c99 -O2 -o qsort singleThread.c

kway.o: kway.c kway.h
		mpicc -c kway.c -o kway.o
debug.o: debug.c debug.h
		mpicc -c debug.c -o debug.o

submit:
	git add -A .
clean:
	rm -rf core a.out mypsrs output.txt *~