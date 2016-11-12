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
    outf = fopen(FileName,"w");

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
    if (taskid == MASTER) {
        t_start = MPI_Wtime();
    } 
    if (taskid == MASTER) 
    {
        MPI_Scatterv(testData, partLen, partIndex, MPI_LONG, MPI_IN_PLACE, N/Nthr, MPI_LONG, MASTER, MPI_COMM_WORLD);
    } else {
        MPI_Scatterv(testData, partLen, partIndex, MPI_LONG, testData, N/Nthr, MPI_LONG, MASTER, MPI_COMM_WORLD);
    }
    MPI_Barrier(MPI_COMM_WORLD);


    qsort(testData,chunkSize,sizeof(long int), cmpfunc);

    if (taskid == MASTER) {
        t_end = MPI_Wtime();
        fprintf(outf,"Phase1: %f\n", t_end-t_start);
    }

    /* Phase 2 */
    if (taskid == MASTER) {
        t_start = MPI_Wtime();
    } 
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

    if (taskid == MASTER) {
        t_end = MPI_Wtime();
        fprintf(outf,"Phase2: %f\n", t_end-t_start);
    }

    /* Phase 3 */
    if (taskid == MASTER) {
        t_start = MPI_Wtime();
    } 
    int classStart[Nthr-1];
    int classLength[Nthr];
    
    // need for each processor to partition its list using the values
    // of pivotbuffer

    int dataindex=0;
    for(int classindex=0; classindex<Nthr-1; classindex++)
    {
        // as long as dataindex refers to data in the current class
		int dataindex = binarySearch(testData, 0, chunkSize-1, pivots[classindex]);
		classStart[classindex] = dataindex;
        
    }
	int trueStart[Nthr];
	for (int i =0; i< Nthr; i++) {
		if (i ==0) {
			trueStart[i] = 0;		
		} else {
			trueStart[i] = classStart[i-1];		
		}	
	}
	for (int i =0; i<Nthr; i++) {
		classLength[i] = trueStart[i+1] - trueStart[i];
		if (i == Nthr-1) {
			classLength[i] = partLen[taskid]- trueStart[i];		
		}
	}
	
    //classLength[Nthr-1] = partLen[taskid] - dataindex;
    if (taskid == MASTER) {
        t_end = MPI_Wtime();
        fprintf(outf,"Phase3: %f\n", t_end-t_start);
    }

    
    // PHASE 4:  All ith classes are gathered by processor i 
    if (taskid == MASTER) {
        t_start = MPI_Wtime();
    } 

    long int * recvbuffer = calloc(N,sizeof(long int));    
    int recvLengths[Nthr];     
    int recvStarts[Nthr];      
    // processor iprocessor functions as the root and gathers from the
    // other processors all of its sorted values in the iprocessor^th class.  
    for(int iprocessor=0; iprocessor<Nthr; iprocessor++)
    {   
        
        // Each processor, iprocessor gathers up the numproc lengths of the sorted
        // values in the iprocessor class
        MPI_Gather(&classLength[iprocessor], 1, MPI_INT, 
            recvLengths,1,MPI_INT,iprocessor,MPI_COMM_WORLD);

        MPI_Barrier(MPI_COMM_WORLD);
    

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
        MPI_Gatherv(&testData[trueStart[iprocessor]],
            classLength[iprocessor],MPI_LONG,
            recvbuffer,recvLengths,recvStarts,MPI_LONG,iprocessor,MPI_COMM_WORLD);
        MPI_Barrier(MPI_COMM_WORLD);
    }
  
    
    // multimerge these numproc lists on each processor
    long int *mmStarts[Nthr]; 

    for(int i=0;i<Nthr;i++)
    {
        mmStarts[i]=recvbuffer+recvStarts[i];
    }
    multimerge(mmStarts,recvLengths,Nthr,testData);
    

    int mysendLength = recvStarts[Nthr-1] + recvLengths[Nthr-1];
    if (taskid == MASTER) {
        t_end = MPI_Wtime();
        fprintf(outf,"Phase4: %f\n", t_end-t_start);
    }

    // PHASE VI:  Root processor collects all the data


    int sendLengths[Nthr]; 
    int sendStarts[Nthr];  
    
    MPI_Gather(&mysendLength,1,MPI_INT,
        sendLengths,1,MPI_INT,MASTER,MPI_COMM_WORLD);
    MPI_Barrier(MPI_COMM_WORLD);

    
    if (taskid == 0)
    {
        sendStarts[0]=0;
        for(int i=1; i<Nthr; i++)
        {
            sendStarts[i] = sendStarts[i-1]+sendLengths[i-1];
        }   
    }

    
    long int * sortedData = calloc(N,sizeof(long int));
    MPI_Gatherv(testData,mysendLength,MPI_LONG,
        sortedData,sendLengths,sendStarts,MPI_LONG,MASTER,MPI_COMM_WORLD);    
    
    MPI_Barrier(MPI_COMM_WORLD);

    
    // Finalize the MPI environment.
    if (taskid == 0) {
        //printArr(sortedData,N);
        if (isSorted(sortedData,N) == 1) {
            printf("Is sorted Thanks my folks!\n");
        }
    }
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
