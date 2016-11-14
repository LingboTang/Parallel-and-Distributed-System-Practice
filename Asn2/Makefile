run:build
	./qsort 64000000 single.csv
	./qsort 64000000 single.csv
	./qsort 64000000 single.csv
	./qsort 64000000 single.csv
	./qsort 64000000 single.csv
	./qsort 64000000 single.csv
	./qsort 64000000 single.csv
	./qsort 32000000 single.csv
	./qsort 32000000 single.csv
	./qsort 32000000 single.csv
	./qsort 32000000 single.csv
	./qsort 32000000 single.csv
	./qsort 32000000 single.csv
	./qsort 32000000 single.csv
	./qsort 16000000 single.csv
	./qsort 16000000 single.csv
	./qsort 16000000 single.csv
	./qsort 16000000 single.csv
	./qsort 16000000 single.csv
	./qsort 16000000 single.csv
	./qsort 16000000 single.csv
	./qsort 8000000 single.csv
	./qsort 8000000 single.csv
	./qsort 8000000 single.csv
	./qsort 8000000 single.csv
	./qsort 8000000 single.csv
	./qsort 8000000 single.csv
	./qsort 8000000 single.csv
build: clean
	mpicc -std=gnu99 -O2 -w -o mypsrs my_psrs.c -pthread -g
	mpicc -std=gnu99 -O2 -w -o total total.c -pthread -g

qsort: clean
	gcc -std=c99 -O2 -o qsort singleThreadSort.c

submit:
	git add -A .
clean:
	rm -rf core a.out total mypsrs qsort *~ *.dSYM/