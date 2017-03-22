#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <string.h>
#include <malloc.h>
#include <unistd.h>
#include <pthread.h>
#include <limits.h>
#include <time.h>
#define NUM_THREADS 3

typedef struct ThreadControlBlock {
	long int *Chunk;
	int *passLength;
	int *sampleIndex;
	int *eachStartIndex;
	long int **tmpMergeSpace;
	long int *pivotArray;
	long int *selectedPivot;
	long int *samples;
	int *mergeLength;
	long int * resultArr;
	int pid;
	int N;
	int num_threads;
	int ChunkSize;
	int offSet;
} TCB;

pthread_t ThreadID[NUM_THREADS];


void * mySPMDMain(void *);

pthread_barrier_t mybarrier;


int cmpfunc(const void*a, const void*b);
int sumTotal(int *arr);
void printArr(long int* arr, int size);
void printArrInt(int* arr, int size);
void multimerge(long int ** arrays, int * arraysizes, int number_of_arrays, long int * output);
int binarySearch(long int *arr, int l, int r, long int x);


int main (int argc, char ** argv) {
	/* Initialize global data here */
	/* Start threads*/

    int i;

	if (argc != 2)
	{
		fprintf(stderr, "error: Not enough info!\n");
		exit(EXIT_FAILURE);
	}

    pthread_barrier_init(&mybarrier, NULL, NUM_THREADS);

	int N = atoi(argv[1]);
	int allChunkSize = N/NUM_THREADS;
	int allSampleSize = NUM_THREADS;

    long int * originArray = (long int *) malloc(sizeof(long int)*N);

    for (i = 0; i<N; i++)
    {
        originArray[i] = random()%36;
    }

    printf("++++++++++Origin+++++++++++\n");
    printArr(originArray, N);

    /*Initialize the Data Space*/
	TCB *myTCB = (TCB *) malloc(sizeof(TCB) *NUM_THREADS); 
	for (i = 0; i<NUM_THREADS; i++)
	{
		myTCB[i].Chunk = (long int*) malloc(sizeof(long int)*allChunkSize);
		myTCB[i].passLength = (int*) malloc(sizeof(long int)*NUM_THREADS);
		myTCB[i].samples = (long int*) malloc(sizeof(long int)*NUM_THREADS);
		myTCB[i].tmpMergeSpace = (long int**) malloc(sizeof(long int *)*NUM_THREADS);
		myTCB[i].pivotArray = (long int *) malloc(sizeof(long int)*NUM_THREADS*NUM_THREADS);
		myTCB[i].selectedPivot = (long int*) malloc(sizeof(long int)*NUM_THREADS-1);
		myTCB[i].sampleIndex = (int*) malloc(sizeof(long int)*NUM_THREADS-1);
		myTCB[i].eachStartIndex = (int*) malloc(sizeof(long int)*NUM_THREADS);
		myTCB[i].mergeLength = (int *) malloc(sizeof(long int)*NUM_THREADS);
		//myTCB[i].resultArr = (long int*) malloc(sizeof(long int)*allChunkSize);
		memcpy(myTCB[i].Chunk, &originArray[i*allChunkSize],allChunkSize*sizeof(long int));
		myTCB[i].N = N;
		myTCB[i].num_threads = NUM_THREADS;
		myTCB[i].ChunkSize = allChunkSize;
		myTCB[i].offSet = N/(NUM_THREADS * NUM_THREADS);
	}

	for (i = 1; i < NUM_THREADS; i++)
	{
		myTCB[i].pid = i; 
		pthread_create(&(ThreadID[i]),NULL, mySPMDMain, (void*) &(myTCB[i]));
	}
	myTCB[0].pid = 0;
	mySPMDMain((void *) &(myTCB[0]));
	
	for (i = 1; i<NUM_THREADS; i++)
	{
		pthread_join(ThreadID[i], NULL);
	}

	/*
	 * Debugging Each Step
	 */
	for (i = 0; i<NUM_THREADS; i++)
	{
	    printf("=======Chunks======\n");
		printArr(myTCB[i].Chunk, allChunkSize);
		printf("=======Pivots===========\n");
		printArr(myTCB[i].pivotArray, NUM_THREADS*NUM_THREADS);
		printf("========Selected=================\n");
		printArr(myTCB[i].selectedPivot, NUM_THREADS-1);
		printf("========SampleIndex===================\n");
		printArrInt(myTCB[i].sampleIndex, NUM_THREADS-1);
		printf("=========Each Start Index=============\n");
		printArrInt(myTCB[i].eachStartIndex, NUM_THREADS);
		printf("=========passLength====================\n");
		printArrInt(myTCB[i].passLength, NUM_THREADS);
	}

    printf("========Merge Space========\n");
	for (i = 0; i < NUM_THREADS; i++)
	{
	    for (int j = 0; j< NUM_THREADS; j++)
	    {
	        printArr(myTCB[i].tmpMergeSpace[j], myTCB[j].passLength[i]);
	    }
	}

	printf("\n========Each Thread Result========\n");
	for (i = 0; i<NUM_THREADS; i++)
	{
	    printArr(myTCB[i].resultArr, sumTotal(myTCB[i].mergeLength));
	}

    memset(originArray, 0, N*sizeof(long int));
    printArr(originArray, N);
    for (i = 0; i<NUM_THREADS; i++)
    {
        int cursor = 0;
        memcpy(&originArray[cursor], myTCB[i].resultArr, sumTotal(myTCB[i].mergeLength) * sizeof(long int));
        cursor = cursor+sumTotal(myTCB[i].mergeLength);
    }

    printArr(originArray, N);
	/* Clean up and exit*/
	pthread_barrier_destroy(&mybarrier);
	free(originArray);
	return 0;
}

#define MASTER if(localId == 0)

void * mySPMDMain(void *arg)
{
	TCB * localTCB;
	int localId;
	pthread_t * localThreadIdPtr;

	/* Actual parameter */
	localTCB = (TCB *)arg;

	/* Other parameters passed in via global */
	localId = localTCB -> pid;

	/* Parallel array to TCB */
	qsort(localTCB -> Chunk, localTCB -> ChunkSize, sizeof(long int), cmpfunc);
	pthread_barrier_wait(&mybarrier);

	// Timing

	/* Phase 1 */
	for (int i = 0; i< localTCB -> num_threads; i++)
	{
		long int sample = localTCB->Chunk[i*localTCB -> offSet];
		localTCB->samples[i]=sample;
	}
	pthread_barrier_wait(&mybarrier);


	/* Phase 2 */
	MASTER {
		for (int i = 0; i<NUM_THREADS; i++)
		{
			memcpy(&(localTCB->pivotArray[i*NUM_THREADS]),localTCB[i].samples, NUM_THREADS*sizeof(long int));
		}
		qsort(localTCB -> pivotArray, NUM_THREADS*NUM_THREADS, sizeof(long int), cmpfunc);
		for (int i = 0; i<NUM_THREADS-1; i++)
		{	
			localTCB-> selectedPivot[i] = localTCB-> pivotArray[(i+1)*NUM_THREADS];
		}
		for (int i = 1; i<NUM_THREADS; i++)
		{
			memcpy(localTCB[i].selectedPivot,localTCB[0].selectedPivot,(NUM_THREADS-1)*sizeof(long int));
		}
	}
	pthread_barrier_wait(&mybarrier);


	/* Phase 3 */
	for (int i = 0; i<NUM_THREADS-1; i++)
	{
		localTCB -> sampleIndex[i] = binarySearch(localTCB->Chunk,0,localTCB->ChunkSize -1, localTCB->selectedPivot[i]);
	}
	for (int i = 0; i<NUM_THREADS; i++)
	{
		if(i == 0) localTCB -> eachStartIndex[i] = 0;
		else localTCB -> eachStartIndex[i] = localTCB -> sampleIndex[i-1];
	}
	for (int i = 0; i<NUM_THREADS; i++)
	{
		if (i == 0) localTCB -> passLength[i] = localTCB -> sampleIndex[i];
		localTCB -> passLength[i] = localTCB -> sampleIndex[i] - localTCB -> sampleIndex[i-1];
		if (i == NUM_THREADS-1) localTCB -> passLength[i] = localTCB -> ChunkSize - localTCB -> sampleIndex[i-1];
	}
	pthread_barrier_wait(&mybarrier);


	/* Phase 4 */
	MASTER {
		for (int i = 0; i<NUM_THREADS; i++)
		{
			for (int j = 0; j<NUM_THREADS; j++)
			{
			    // each temp merge space  = localTCB[i].tmpMergeSpace[j]
                // each cpy start = localTCB[j].Chunk[localTCB[j].eachStartIndex[i]]
                // each cpy length = localTCB[j].passLength[i] * sizeof(long int)
				localTCB[i].tmpMergeSpace[j] = (long int*) malloc(sizeof(long int)*localTCB[j].passLength[i]);
				localTCB[i].mergeLength[j] = localTCB[j].passLength[i];
				memcpy(localTCB[i].tmpMergeSpace[j], &(localTCB[j].Chunk[localTCB[j].eachStartIndex[i]]), (localTCB[j].passLength[i]) * sizeof(long int));
			}
			localTCB[i].resultArr = (long int *) malloc(sizeof(long int)*sumTotal(localTCB[i].mergeLength));
		}
	}
	pthread_barrier_wait(&mybarrier);
    multimerge(localTCB->tmpMergeSpace,localTCB->mergeLength,NUM_THREADS,localTCB->resultArr);
    pthread_barrier_wait(&mybarrier);
	//Timing 

} /* mySPMDMain*/

int sumTotal(int *arr)
{
    int total = 0;
    for (int i = 0; i<sizeof(arr)/sizeof(arr[0])+1; i++)
    {
        total = total+arr[i];
    }
    return total;
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


int cmpfunc(const void*a, const void*b)
{
	return (*(long int*)a - *(long int*)b);
}

void multimerge(long int ** arrays, int * arraysizes, int number_of_arrays, long int * output) {
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

            if(cursor[j] < arraysizes[j] && arrays[j][cursor[j]] < min){  
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