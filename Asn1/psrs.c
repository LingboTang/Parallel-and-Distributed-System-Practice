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
#define NUM_THREADS 4

typedef struct ThreadControlBlock {
	long int *passLength;
	long int *sampleIndex;
	long int *pivotArray;
	long int *sample;
	int pid;
	int N;
	int num_threads;
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

	if (argc != 3)
	{
		fprintf(stderr, "error: Not enough info!\n");
		exit(EXIT_FAILURE);
	}

    pthread_barrier_init(&mybarrier, NULL, NUM_THREADS+1);

	int N = atoi(argv[1]);
	//int NUM_THREADS = atoi(argv[2]);
	int allChunkSize = N/NUM_THREADS;
	int allSampleSize = NUM_THREADS;

    long int * originArray = (long int *) malloc(sizeof(long int *)*N);

    for (i = 0; i<N; i++)
    {
        originArray[i] = random();
    }

    printArr(originArray, N);
	//TCB myTCB 


	for (i = 1; i < NUM_THREADS; i++)
	{
		//TCB[i].id = i; /* In  parameter */
		//pthread_create(&(ThreadID[i]),NULL, mySPMDMain, (void*) &(TCB[i]));
	}
	//TCB[0].id = 0;
	//mySPMDMain((void *) &(TCB[0]));

	/* Clean up and exit*/
	return 0;
}

#define MASTER if(localId == 0)
#define BARRIER pthread_barrier_wait(&mybarrier)

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
	localThreadIdPtr = &(ThreadID[localId]);
	BARRIER;
	// Timing

	/* Phase 1 */
	BARRIER;

	/* Phase 2 */
	if(localId == 0) {
		
	}
	BARRIER;


	/* Phase 3 */
	BARRIER;

	/* Phase 4 */
	BARRIER;

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