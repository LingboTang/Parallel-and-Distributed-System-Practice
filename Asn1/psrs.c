#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <string.h>
#include <malloc.h>
#include <unistd.h>
#include <pthread.h>
#include <time.h>
#define NUM_THREADS 3

typedef struct ThreadControlBlock {
	long int *Chunk;
	long int *passLength;
	long int *sampleIndex;
	long int *pivotArray;
	long int *samples;
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
void printArr(long int* arr, int size);

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

	TCB *myTCB = (TCB *) malloc(sizeof(TCB) *NUM_THREADS); 
	for (i = 0; i<NUM_THREADS; i++)
	{
		myTCB[i].Chunk = (long int*) malloc(sizeof(long int)*allChunkSize);
		myTCB[i].samples = (long int*) malloc(sizeof(long int)*NUM_THREADS);
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

	for (i = 0; i<NUM_THREADS; i++)
	{
		//printArr(myTCB[i].Chunk, allChunkSize);
		printArr(myTCB[i].samples, NUM_THREADS);
	}
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
		
	}
	pthread_barrier_wait(&mybarrier);


	/* Phase 3 */
	pthread_barrier_wait(&mybarrier);


	/* Phase 4 */
	pthread_barrier_wait(&mybarrier);

	//pthread_barrier_destroy(&mybarrier);
	//Timing 

} /* mySPMDMain*/


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
