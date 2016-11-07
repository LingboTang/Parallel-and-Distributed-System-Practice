#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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

void printArrInt(int* arr, int size)
{

    for (int i = 0; i< size; i++)
    {
        if (i == 0)
        {
            printf("[ ");
        }
        printf("%d ",arr[i]);
        if (i == size -1)
        {
            printf("]\n");
        }
    }
}

int isSorted(long int * arr, int size) {
    for (int i = 0; i<size -1; i++) {
        if (arr[i] > arr[i+1]) {
            return 0;
        }
    } 

    return 1;
}

int cmpfunc(const void*a, const void*b)
{
    return (*(long int*)a - *(long int*)b);
}

int main(int argc, char** argv) {
    // Initialize the MPI environment
    MPI_Init(NULL, NULL);
    int taskid, N, Nthr;
    MPI_Comm_size(MPI_COMM_WORLD, &Nthr);
    MPI_Comm_rank(MPI_COMM_WORLD, &taskid);
    
    /* Parse argument line */
    if (argc != 3) {
        if (taskid == MASTER)
        {
            fprintf(stderr, "Usage: ./psrsTest "" nInts outputfile\n");
        } 
        MPI_Finalize();
        exit(0);
    }

    N = atoi(argv[1]);

    if (N % Nthr != 0) {
        if (taskid == MASTER)
        {
            fprintf(stderr, "Total must be divided evenly for analysis purpose\n");
        } 
        MPI_Finalize();
        exit(1);
    }

    if ((N % (Nthr * Nthr)) != 0) {
        if (taskid == MASTER)
        {
            fprintf(stderr, "Total must be divided evenly for analysis purpose\n");
        } 
        MPI_Finalize();
        exit(2);
    }

    /* Initialize test Array */
    long int testData[N];
    int chunkSize = N/Nthr;
    long int subData[chunkSize];
    int offSet = N/(Nthr* Nthr);
    long int pivots[Nthr*Nthr];
    int partIndex[Nthr];

    if (taskid == MASTER) {
        srandom(MYSEED);
        for (int i = 0; i < N; i++)
        {
            testData[i] = random()%1000;
        }
    }

    for (int i =0; i< Nthr; i++) {
        partIndex[i] = i*chunkSize;
    }

    printArrInt(partIndex, Nthr);
    if (taskid == MASTER) 
    {
        MPI_Scatter(testData, N/Nthr, MPI_LONG, subData, N/Nthr, MPI_LONG, MASTER, MPI_COMM_WORLD);
    } else {
        MPI_Scatter(testData, N/Nthr, MPI_LONG, subData, N/Nthr, MPI_LONG, MASTER, MPI_COMM_WORLD);
    }
    printArr(subData,chunkSize);

    qsort(subData,chunkSize,sizeof(long int), cmpfunc);

    printArr(subData,chunkSize);
    if (isSorted(subData,chunkSize) == 1) {
        printf("Sorted\n");
    }


    // Finalize the MPI environment.
    MPI_Finalize();
    return 0;
}