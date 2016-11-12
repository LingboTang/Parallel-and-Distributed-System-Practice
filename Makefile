run:build
	mpirun -np 4 ./mypsrs 32000000 output.txt
build: clean
	mpicc -std=gnu99 -O2 -w -o mypsrs my_psrs.c -pthread -g
	mpicc -std=gnu99 -O2 -w -o total total.c -pthread -g
	gcc -std=gnu99 -O2 -w -o qsort singleThreadSort.c -pthread -g


submit:
	git add -A .
clean:
	rm -rf core a.out mypsrs *.txt *~ *.dSYM/
