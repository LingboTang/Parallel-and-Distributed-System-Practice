#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <math.h>
#include <time.h>
#include "mpi.h"
#include "kway.h"
//#include "debug.h"
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
    //long int subData[chunkSize];
    int offSet = N/(Nthr* Nthr);
    long int pivots[Nthr*Nthr];
    int partIndex[Nthr];
    int partLen[Nthr];

    if (taskid == MASTER) {
        srandom(MYSEED);
        for (int i = 0; i < N; i++)
        {
            testData[i] = random()%1000;
        }
    }

    for (int i =0; i< Nthr; i++) {
        partIndex[i] = i*chunkSize;
        partLen[i] = chunkSize;
    }

    if (taskid == MASTER) 
    {
        MPI_Scatterv(testData, partLen, partIndex, MPI_LONG, MPI_IN_PLACE, N/Nthr, MPI_LONG, MASTER, MPI_COMM_WORLD);
    } else {
        MPI_Scatterv(testData, partLen, partIndex, MPI_LONG, testData, N/Nthr, MPI_LONG, MASTER, MPI_COMM_WORLD);
    }
    MPI_Barrier(MPI_COMM_WORLD);
    

    qsort(testData,chunkSize,sizeof(long int), cmpfunc);

    // Debug scatter
    printArr(testData,chunkSize);
    /*if (isSorted(testData,chunkSize) == 1) {
        printf("Sorted\n");
    }*/

    for (int i = 0; i<Nthr; i++) {
        pivots[i] = testData[i*offSet];
    }

    if (taskid == MASTER) {
        MPI_Gather(MPI_IN_PLACE,Nthr,MPI_LONG,
            pivots,Nthr,MPI_LONG,MASTER,MPI_COMM_WORLD);
    } else {
        MPI_Gather(pivots,Nthr,MPI_LONG,pivots,Nthr,MPI_LONG,MASTER,MPI_COMM_WORLD);
    }

    if (taskid == MASTER) {
        printArr(pivots,Nthr*Nthr);
        int *Ind[Nthr];
        int Len[Nthr];
        for (int i = 0; i<Nthr; i++) {
            Ind[i] = &pivots[i*Nthr];
            Len[i] = Nthr;
        }
        printArr(Ind[2],Nthr);
        printArrInt(Len,Nthr);
        /*long int tmp[Nthr*Nthr];
        multimerge(Ind, lengths, Nthr, tmp, Nthr*Nthr);
        for(int i =0; i<Nthr-1; i++) {
            pivots[i] = tmp[(i+1)*Nthr];
        }*/
    }

    /*MPI_Bcast(pivots,Nthr-1,MPI_LONG,MASTER,MPI_COMM_WORLD);


    int tmpPart[Nthr];
    int tmpLen[Nthr];

    int di = 0;
    int pi;
    for (pi =0; pi<Nthr-1; pi++) {
        tmpPart[pi] = di;
        tmpLen[pi] = 0;

        while ((di < tmpLen[taskid]) && (myData[di]<=pivots[pi]))
        {
            tmpLen[pi]++;
            di++;
        }    
    }

    tmpPart[Nthr-1] = di;
    tmpLen[Nthr-1] = partLen - di;


    long int recv[N];
    int recvLen[Nthr];
    int recvInd[Nthr];

    for (int which_id = 0; which_id < Nthr; which_id ++) {
        MPI_Gather(tmpPart[Nthr], 1, MPI_LONG, recvLen,1,MPI_LONG,which_id,MPI_COMM_WORLD);

        if (taskid == which_id) {
            recvInd[0]=0;
            for(int i =1; i<Nthr;i++) {
                recvInd[i] = recvInd[i-1] + recvLen[i-1];
            }
        }

        MPI_Gatherv(testData[recvInd[which_id]],recvLen[which_id], MPI_LONG,recv,recvLen,recvInd,MPI_LONG,which_id,MPI_COMM_WORLD);
    }

    int *finalInd[Nthr]; // array of list starts
    for(int i=0;i<Nthr;i++)
    {
        mmStarts[i]=recvbuffer+recvStarts[i];
    }
    multimerge(mmStarts,recvLengths,Nthr,myData,myDataSize);
    
    int mysendLength = recvStarts[Nthr-1] + recvLengths[Nthr-1];
    
    // PHASE VI:  Root processor collects all the data


    int sendLengths[Nthr]; // lengths of consolidated classes
    int sendStarts[Nthr];  // starting points of classes
    // Root processor gathers up the lengths of all the data to be gathered
    MPI::COMM_WORLD.Gather(&mysendLength,1,MPI::INT,
        sendLengths,1,MPI::INT,0);

    // The root processor compute starts from lengths of classes to gather
    if (myid == 0)
    {
        sendStarts[0]=0;
        for(int i=1; i<Nthr; i++)
        {
            sendStarts[i] = sendStarts[i-1]+sendLengths[i-1];
        }   
    }

    // Now we let processor #0 gather the pieces and glue them together in
    // the right order
    int sortedData[myDataSize];
    MPI_Gatherv(testData,mysendLength,MPI_LONG,
        sortedData,sendLengths,sendStarts,MPI_LONG,MASTER,MPI_COMM_WORLD);
    // Finalize the MPI environment.*/
    MPI_Finalize();
    return 0;
}