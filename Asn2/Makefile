run:build
	mpirun -np 3 mpi_psrs 36 3 output.txt
build: clean
	mpicc -O1 -w -o mpi_psrs mpi_psrs.c -pthread -g
submit:
	git add -A .
clean:
	rm -rf core a.out mpi_psrs *~