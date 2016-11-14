run:build
	mpirun -np 8 ./mypsrs 64000000 my.csv


build: clean
	mpicc -std=gnu99 -O2 -w -o mypsrs my_psrs.c -pthread -g
	mpicc -std=gnu99 -O2 -w -o total total.c -pthread -g
	gcc -std=gnu99 -O2 -o qsort singleThreadSort.c -g

submit:
	git add -A .
clean:
	rm -rf core a.out mypsrs total qsort *~ *.dSYM/
