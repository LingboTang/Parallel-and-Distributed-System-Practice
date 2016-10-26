#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>
#include <time.h>
#include "mpi.h"

#define MASTER 0
#define MYSEED 23478237

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

int cmpfunc(const void*a, const void*b)
{
    return (*(long int*)a - *(long int*)b);
}


void phase1() 
{

}

int main(int argc, char *argv[])
{

    
    /* Global Variables */
    int N, thrN, taskid;
    char * outputFilename;
    FILE * outfp;

    printf("How many arguments?: %d\n",argc);
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
    long int * subRand = (long int *) malloc(sizeof(long int)*N/thrN);
    srandom(MYSEED);

    for (int i = 0; i < N; i++)
    {
        randArray[i] = random()%36;
    }

    MPI_Init(&argc, &argv);
    
    MPI_Comm_size(MPI_COMM_WORLD, &thrN);
    MPI_Comm_rank(MPI_COMM_WORLD,&taskid);

    printArr(randArray, N);
    printf("This is Length of Origin Array: %d\n", thrN);
    
    /* Start */
    printf("Before iter\n");
    for (int i = 0; i < thrN - 1; i++)
    {
        printf("In iter\n");

        memset(subRand, 0, N/thrN * sizeof(long int));
        if (taskid == MASTER) {
            MPI_Scatter(randArray, N/thrN, MPI_LONG, subRand, N/thrN, MPI_LONG, MASTER, MPI_COMM_WORLD);
        }

        qsort(subRand, N/thrN, sizeof(long int), cmpfunc);    
        printf("taskid: %d \n", taskid);
        printArr(subRand, N/thrN);

    }
    printf("After iter\n");


    MPI_Finalize();    
    free(randArray);
    free(subRand);
    fclose(outfp);
    return 0;   
}