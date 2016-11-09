#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <math.h>
#include <time.h>
#include "mpi.h"
//#include "kway.h"
//#include "debug.h"
#define MASTER 0
#define MYSEED 23478237


#include <stdio.h>
#include <stdlib.h>
#include <limits.h>


/* Modified code from http://stackoverflow.com/questions/10774566/merging-multiple-sorted-arrays-in-c */
void multimerge(
    long int ** arrays,      // arrays holding the data
    int * arraysizes,    // sizes of the arrays in `arrays`
    int number_of_arrays,            // number of arrays
    long int * output               // pointer to output buffer
){
    int i = 0;       // output cursor
    int j = 0;       // index for minimum search
    int min;         // minimum in this iteration
    int minposition; // position of the minimum

    // cursor for the arrays
    long int * cursor = calloc(number_of_arrays,sizeof(long int));

    if(cursor == NULL)
        return;

    while(1){
        min = INT_MAX;
        minposition = -1; // invalid position

        // Go through the current positions and get the minimum
        for(j = 0; j < number_of_arrays; ++j){

            if(cursor[j] < arraysizes[j] &&  // ensure that the cursor is still valid
               arrays[j][cursor[j]] < min){  // the element is smaller
                min = arrays[j][cursor[j]];  // save the minimum ...
                minposition = j;             // ... and its position
            }
        }

        // if there is no minimum, then the position will be invalid

        if(minposition == -1)
            break;

        // update the output and the specific cursor            
        output[i++] = min;
        cursor[minposition]++;
    }
    free(cursor);
}

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
            fprintf(stderr, "Usage: ./mypsrs <N> <outputfile>\n");
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
            testData[i] = random()%40;
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
    //printArr(testData,chunkSize);
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
        long int *Ind[Nthr];
        int Len[Nthr];
        for (int i = 0; i<Nthr; i++) {
            Ind[i] = &pivots[i*Nthr];
            Len[i] = Nthr;
        }

        long int tmp[Nthr*Nthr];
        multimerge(Ind,Len,Nthr,tmp);
        //printArr(tmp, Nthr*Nthr);
        for(int i =0; i<Nthr-1; i++) {
            pivots[i] = tmp[(i+1)*Nthr];
        }
        //printArr(pivots,Nthr-1);
    }

    MPI_Bcast(pivots,Nthr-1,MPI_LONG,MASTER,MPI_COMM_WORLD);


    int classStart[Nthr];
    int classLength[Nthr];
    
    // need for each processor to partition its list using the values
    // of pivotbuffer
    int dataindex=0;
    for(int classindex=0; classindex<Nthr-1; classindex++)
    {
        classStart[classindex] = dataindex;
        classLength[classindex]=0;

        // as long as dataindex refers to data in the current class
        while((dataindex< partLen[taskid]) 
            && (testData[dataindex]<=pivots[classindex]))
        {
            classLength[classindex]++;
            dataindex++;
        }       
    }
    // set Start and Length for last class
    classStart[Nthr-1] = dataindex;
    classLength[Nthr-1] = partLen[taskid] - dataindex;
    /*printf("Start Mother Fucker\n");
    printArrInt(classStart,Nthr);
    printf("Length Mother Fucker\n");
    printArrInt(classLength,Nthr);*/

    
    // PHASE V:  All ith classes are gathered by processor i 
    long int recvbuffer[N];    // buffer to hold all members of class i
    int recvLengths[Nthr];     // on myid, lengths of each myid^th class
    int recvStarts[Nthr];      // indices of where to start the store from 0, 1, ...

    // processor iprocessor functions as the root and gathers from the
    // other processors all of its sorted values in the iprocessor^th class.  
    for(int iprocessor=0; iprocessor<Nthr; iprocessor++)
    {   
        // Each processor, iprocessor gathers up the numproc lengths of the sorted
        // values in the iprocessor class
        MPI_Gather(&classLength[iprocessor], 1, MPI_INT, 
            recvLengths,1,MPI_INT,iprocessor,MPI_COMM_WORLD);
    

        // From these lengths the myid^th class starts are computed on
        // processor myid
        if (taskid == iprocessor)
        {
            recvStarts[0]=0;
            for(int i=1;i<Nthr; i++)
            {
                recvStarts[i] = recvStarts[i-1]+recvLengths[i-1];
            }
        }

        // each iprocessor gathers up all the members of the iprocessor^th 
        // classes from the other nodes
        MPI_Gatherv(&testData[classStart[iprocessor]],
            classLength[iprocessor],MPI_LONG,
            recvbuffer,recvLengths,recvStarts,MPI_LONG,iprocessor,MPI_COMM_WORLD);
    }
        
    
    // multimerge these numproc lists on each processor
    long int *mmStarts[Nthr]; // array of list starts
    long int tmpMerge[N];
    for(int i=0;i<Nthr;i++)
    {
        mmStarts[i]=recvbuffer+recvStarts[i];
    }
    multimerge(mmStarts,recvLengths,Nthr,tmpMerge);
    
    /*if (taskid == MASTER) {
        printArr(testData,N);    
    }*/
    
    for (int i = 0; i< Nthr; i++) {
        printArr(mmStarts[i],recvLengths[i]);
    }
    int mysendLength = recvStarts[Nthr-1] + recvLengths[Nthr-1];
    

    // PHASE VI:  Root processor collects all the data


    int sendLengths[Nthr]; // lengths of consolidated classes
    int sendStarts[Nthr];  // starting points of classes
    // Root processor gathers up the lengths of all the data to be gathered
    MPI_Gather(&mysendLength,1,MPI_INT,
        sendLengths,1,MPI_INT,MASTER,MPI_COMM_WORLD);


    // The root processor compute starts from lengths of classes to gather
    if (taskid == 0)
    {
        sendStarts[0]=0;
        for(int i=1; i<Nthr; i++)
        {
            sendStarts[i] = sendStarts[i-1]+sendLengths[i-1];
        }   
    }

    // Now we let processor #0 gather the pieces and glue them together in
    // the right order
    long int sortedData[N];
    MPI_Gatherv(tmpMerge,mysendLength,MPI_LONG,
        sortedData,sendLengths,sendStarts,MPI_LONG,MASTER,MPI_COMM_WORLD);    
    
    
    //MPI_Barrier(MPI_COMM_WORLD);
    // Finalize the MPI environment.
    if (taskid == 0) {
        printArr(sortedData,N);
    }
    MPI_Finalize();
    return 0;
}