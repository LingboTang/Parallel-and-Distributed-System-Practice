#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <math.h>
#include <time.h>
#include "mpi.h"
#define MASTER 0
#define MYSEED 23478237


/* Modified code from http://stackoverflow.com/questions/10774566/merging-multiple-sorted-arrays-in-c */
void multimerge(
    long int ** arrays,      
    int * arraysizes,    
    int number_of_arrays,            
    long int * output               
){
    int i = 0;       
    int j = 0;       
    int min;         
    int minposition; 

  
    long int * cursor = calloc(number_of_arrays,sizeof(long int));

    if(cursor == NULL)
        return;

    while(1){
        min = INT_MAX;
        minposition = -1; 

        
        for(j = 0; j < number_of_arrays; ++j){

            if(cursor[j] < arraysizes[j] &&  
               arrays[j][cursor[j]] < min){  
                min = arrays[j][cursor[j]];  
                minposition = j;             
            }
        }


        if(minposition == -1)
            break;
     
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

int binarySearch(long int *arr, int l, int r, long int x)
{
    if (r>= l)
    {
        int mid = l + (r-l)/2;
        if (arr[mid] == x) return mid + 1;
        if (arr[mid] > x) return binarySearch(arr,l, mid-1, x);
        return binarySearch(arr, mid+1, r, x);
    }
    else {
      return l;
    }
}

int cmpfunc(const void*a, const void*b)
{
    return (*(long int*)a - *(long int*)b);
}

// Inspired by http://csweb.cs.wfu.edu/bigiron/LittleFE-PSRS/build/html/PSRSimplementation.html
int main(int argc, char** argv) {
    // Initialize the MPI environment
    MPI_Init(NULL, NULL);
    int taskid, N, Nthr;
    double t_start, t_end;
    char* FileName;
    FILE * outf;
    MPI_Comm_size(MPI_COMM_WORLD, &Nthr);
    MPI_Comm_rank(MPI_COMM_WORLD, &taskid);
    
    /* Parse argument line */
    if (argc != 3) {
        if (taskid == MASTER)
        {
            fprintf(stderr, "Usage: ./mypsrs <N> <outputfile>\n");
            fflush(stderr);
        } 
        MPI_Finalize();
        exit(0);
    }

    N = atoi(argv[1]);
    FileName = argv[2];
    outf = fopen(FileName,"a+");

    if (N % Nthr != 0) {
        if (taskid == MASTER)
        {
            fprintf(stderr, "Total must be divided evenly for analysis purpose\n");
            fflush(stderr);
        } 
        MPI_Finalize();
        exit(1);
    }

    if ((N % (Nthr * Nthr)) != 0) {
        if (taskid == MASTER)
        {
            fprintf(stderr, "Total must be divided evenly for analysis purpose\n");
            fflush(stderr);
        } 
        MPI_Finalize();
        exit(2);
    }

    /* Initialize test Array */
    long int * testData = calloc(N, sizeof(long int));
    int chunkSize = N/Nthr;
    int offSet = N/(Nthr* Nthr);
    long int * pivots = calloc(Nthr*Nthr, sizeof(long int));
    int * partIndex = calloc(Nthr, sizeof(int));
    int * partLen = calloc(Nthr, sizeof(int));

    if (taskid == MASTER) {
        srandom(MYSEED);
        for (int i = 0; i < N; i++)
        {
            testData[i] = random()%100;
        }
    }

    for (int i =0; i< Nthr; i++) {
        partIndex[i] = i*chunkSize;
        partLen[i] = chunkSize;
    }

    /* Phase 1 */
    
    if (taskid == MASTER) 
    {
        MPI_Scatterv(testData, partLen, partIndex, MPI_LONG, MPI_IN_PLACE, N/Nthr, MPI_LONG, MASTER, MPI_COMM_WORLD);
    } else {
        MPI_Scatterv(testData, partLen, partIndex, MPI_LONG, testData, N/Nthr, MPI_LONG, MASTER, MPI_COMM_WORLD);
    }
    MPI_Barrier(MPI_COMM_WORLD);

    if (taskid == MASTER) {
        t_start = MPI_Wtime();
    } 

    qsort(testData,chunkSize,sizeof(long int), cmpfunc);

    /* Phase 2 */
    
    for (int i = 0; i<Nthr; i++) {
        pivots[i] = testData[i*offSet];
    }

    if (taskid == MASTER) {
        MPI_Gather(MPI_IN_PLACE,Nthr,MPI_LONG,
            pivots,Nthr,MPI_LONG,MASTER,MPI_COMM_WORLD);
    } else {
        MPI_Gather(pivots,Nthr,MPI_LONG,pivots,Nthr,MPI_LONG,MASTER,MPI_COMM_WORLD);
    }
    MPI_Barrier(MPI_COMM_WORLD);

    
    if (taskid == MASTER) {
        long int *Ind[Nthr];
        int Len[Nthr];
        for (int i = 0; i<Nthr; i++) {
            Ind[i] = &pivots[i*Nthr];
            Len[i] = Nthr;
        }

        long int tmp[Nthr*Nthr];
        multimerge(Ind,Len,Nthr,tmp);
        for(int i =0; i<Nthr-1; i++) {
            pivots[i] = tmp[(i+1)*Nthr];
        }
    }


    MPI_Bcast(pivots,Nthr-1,MPI_LONG,MASTER,MPI_COMM_WORLD);
    MPI_Barrier(MPI_COMM_WORLD);


    /* Phase 3 */
    int segStart[Nthr-1];
    int segLen[Nthr];
    

    int di=0;
    for(int classindex=0; classindex<Nthr-1; classindex++)
    {
        int di = binarySearch(testData, 0, chunkSize-1, pivots[classindex]);
        segStart[classindex] = di;
    }
    int trueStart[Nthr];
    for (int i =0; i< Nthr; i++) {
        if (i ==0) {
            trueStart[i] = 0;       
        } else {
            trueStart[i] = segStart[i-1];       
        }   
    }
    for (int i =0; i<Nthr; i++) {
        segLen[i] = trueStart[i+1] - trueStart[i];
        if (i == Nthr-1) {
            segLen[i] = partLen[taskid]- trueStart[i];      
        }
    }


    long int * recvbuffer = calloc(N,sizeof(long int));    
    int recvLen[Nthr];     
    int recvind[Nthr];      

    for(int i=0; i<Nthr; i++)
    {   
        
        MPI_Gather(&segLen[i], 1, MPI_INT, 
            recvLen,1,MPI_INT,i,MPI_COMM_WORLD);

        MPI_Barrier(MPI_COMM_WORLD);
    

        if (taskid == i)
        {
            recvind[0]=0;
            for(int i=1;i<Nthr; i++)
            {
                recvind[i] = recvind[i-1]+recvLen[i-1];
            }
        }

        MPI_Gatherv(&testData[trueStart[i]],
            segLen[i],MPI_LONG,
            recvbuffer,recvLen,recvind,MPI_LONG,i,MPI_COMM_WORLD);
        MPI_Barrier(MPI_COMM_WORLD);
    }
    
    /* Phase 4 */

    long int *multiind[Nthr]; 

    for(int i=0;i<Nthr;i++)
    {
        multiind[i]=recvbuffer+recvind[i];
    }
    multimerge(multiind,recvLen,Nthr,testData);
    

    int mysendLength = recvind[Nthr-1] + recvLen[Nthr-1];

    /* Phase 5 */


    int sendLen[Nthr]; 
    int sendind[Nthr];  
    
    MPI_Gather(&mysendLength,1,MPI_INT,
        sendLen,1,MPI_INT,MASTER,MPI_COMM_WORLD);
    MPI_Barrier(MPI_COMM_WORLD);

    
    if (taskid == 0)
    {
        sendind[0]=0;
        for(int i=1; i<Nthr; i++)
        {
            sendind[i] = sendind[i-1]+sendLen[i-1];
        }   
    }

    
    long int * sortedData = calloc(N,sizeof(long int));
    MPI_Gatherv(testData,mysendLength,MPI_LONG,
        sortedData,sendLen,sendind,MPI_LONG,MASTER,MPI_COMM_WORLD);    
    
    MPI_Barrier(MPI_COMM_WORLD);
    if (taskid == MASTER) {
        t_end = MPI_Wtime();
        fprintf(outf,"%d, %d, %f\n", Nthr, N, t_end-t_start);
    }
    
    // Finalize the MPI environment.
    /*if (taskid == 0) {
        //printArr(sortedData,N);
        if (isSorted(sortedData,N) == 1) {
            printf("Is sorted Thanks my folks!\n");
        }
    }*/
    free(testData);
    free(recvbuffer);
    free(sortedData);
    free(pivots);
    free(partIndex);
    free(partLen);
    fclose(outf);
    MPI_Finalize();
    return 0;
}

