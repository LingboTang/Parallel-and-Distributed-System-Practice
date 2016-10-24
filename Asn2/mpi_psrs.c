#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include "mpi.h"

#define MASTER 0

void printArr(long int* arr, int size)
{

    for (int i = 0; i< size; i++)
    {
        if (i == 0)
        {
            printf("[ ");
        }
        printf("%ld ",arr[i]);
        if (i == size -1)
        {
            printf("]\n");
        }
    }
}

void phase1() 
{

}

int main(int argc, char *argv[])
{

    MPI_Init(&argc, &argv);
    /* Global Variables */
    int N, thrN, taskid;
    char * outputFilename;
    FILE * outfp;

    /* N, P and output get from Command line */
    if (argc < 4)
    {
        fprintf(stderr,"usage: ./mpi_psrs <# of Keys> <# of threads> <Outputfile> \n");
        exit(0);
    }
    N = atoi(argv[1]);
    thrN = atoi(argv[2]);
    outputFilename = argv[3];
    outfp = fopen(outputFilename,"w");

    /* Init the test array*/
    long int * randArray = (long int *) malloc(sizeof(long int)*N);
    long int * subRand = (long int *) malloc(sizeof(long int) * N/thrN);
    srandom(time(NULL));

    for (int i = 0; i < N; i++)
    {
        randArray[i] = random()%36;
    }

    printArr(randArray,N);

    
    /* Start */
    MPI_Comm_size(MPI_COMM_WORLD, &thrN);
    MPI_Comm_rank(MPI_COMM_WORLD,&taskid);

    if (taskid == MASTER) {
        MPI_SCatter(randArray, N/thrN,MPI_LONG,subRand, N/thrN, MPI_LONG, MASTER, MPI_COMM_WORLD);
    }    

    printArr(subRand,N/thrN);

    free(randArray);
    free(subRand);
    fclose(outfp);
    return 0;   
}