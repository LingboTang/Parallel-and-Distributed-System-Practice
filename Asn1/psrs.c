#define _GNU_SOURCE
#include "myutils.h"
#include <pthread.h>

void * mySPMDMain(void *);
pthread_barrier_t mybarrier;

int main (int argc, char ** argv) {
	/* Initialize global data here */
	/* Start threads*/

    int i;

	if (argc != 3)
	{
		fprintf(stderr, "usage: ./psrs <Number of Keys> <Number of threads>\n");
		exit(EXIT_FAILURE);
	}



	int N = atoi(argv[1]);
	int NUM_THREADS = atoi(argv[2]);
	int allChunkSize = N/NUM_THREADS;
	pthread_t ThreadID[NUM_THREADS];
	pthread_barrier_init(&mybarrier, NULL, NUM_THREADS);

    long int * originArray = (long int *) malloc(sizeof(long int)*N);

    for (i = 0; i<N; i++)
    {
        originArray[i] = random();
    }

    /*Initialize the Data Space*/
	TCB *myTCB = (TCB *) malloc(sizeof(TCB) *NUM_THREADS); 
	for (i = 0; i<NUM_THREADS; i++)
	{
		myTCB[i].Chunk = (long int*) malloc(sizeof(long int)*allChunkSize);
		myTCB[i].passLength = (int*) malloc(sizeof(int)*NUM_THREADS);
		myTCB[i].samples = (long int*) malloc(sizeof(long int)*NUM_THREADS);
		myTCB[i].tmpMergeSpace = (long int**) malloc(sizeof(long int *)*NUM_THREADS);
		myTCB[i].pivotArray = (long int *) malloc(sizeof(long int)*NUM_THREADS*NUM_THREADS);
		myTCB[i].selectedPivot = (long int*) malloc(sizeof(long int)*NUM_THREADS-1);
		myTCB[i].sampleIndex = (int*) malloc(sizeof(int)*NUM_THREADS-1);
		myTCB[i].eachStartIndex = (int*) malloc(sizeof(int)*NUM_THREADS);
		myTCB[i].mergeLength = (int *) malloc(sizeof(int)*NUM_THREADS);
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

    memset(originArray, 0, N*sizeof(long int));
    int cursor = 0;
    for (i = 0; i<NUM_THREADS; i++)
    {
        memcpy(&originArray[cursor], myTCB[i].resultArr, sumTotal(myTCB[i].mergeLength, NUM_THREADS) * sizeof(long int));
        cursor = cursor+sumTotal(myTCB[i].mergeLength, NUM_THREADS);
    }
	/* Clean up and exit*/
	pthread_barrier_destroy(&mybarrier);
	assert(isSorted(originArray,N) == 1);
	printArr(originArray, N);
    for (i = 0; i<NUM_THREADS; i++)
    {
        free(myTCB[i].mergeLength);
        free(myTCB[i].eachStartIndex);
        free(myTCB[i].sampleIndex);
        free(myTCB[i].selectedPivot);
        free(myTCB[i].pivotArray);
        free(myTCB[i].samples);
        free(myTCB[i].passLength);
        free(myTCB[i].Chunk);
        free(myTCB[i].resultArr);
        for(int j = 0; j< NUM_THREADS; j++)
        {
            free(myTCB[i].tmpMergeSpace[j]);
        }
        free(myTCB[i].tmpMergeSpace);
    }
    free(myTCB);
	free(originArray);
	return 0;
}

#define MASTER if(localId == 0)

void * mySPMDMain(void *arg)
{
	TCB * localTCB;
	int localId;

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
		for (int i = 0; i < localTCB -> num_threads; i++)
		{
			memcpy(&(localTCB->pivotArray[i*localTCB -> num_threads]),localTCB[i].samples, localTCB -> num_threads*sizeof(long int));
		}
		qsort(localTCB -> pivotArray, localTCB -> num_threads*localTCB -> num_threads, sizeof(long int), cmpfunc);
		for (int i = 0; i<(localTCB -> num_threads)-1; i++)
		{	
			localTCB-> selectedPivot[i] = localTCB-> pivotArray[(i+1)*localTCB -> num_threads];
		}
		for (int i = 1; i<localTCB -> num_threads; i++)
		{
			memcpy(localTCB[i].selectedPivot,localTCB[0].selectedPivot,((localTCB -> num_threads)-1)*sizeof(long int));
		}
	}
	pthread_barrier_wait(&mybarrier);


	/* Phase 3 */
	for (int i = 0; i<(localTCB -> num_threads)-1; i++)
	{
		localTCB -> sampleIndex[i] = binarySearch(localTCB->Chunk,0,localTCB->ChunkSize -1, localTCB->selectedPivot[i]);
	}
	for (int i = 0; i<localTCB -> num_threads; i++)
	{
		if(i == 0) localTCB -> eachStartIndex[i] = 0;
		else localTCB -> eachStartIndex[i] = localTCB -> sampleIndex[i-1];
	}
	for (int i = 0; i<localTCB -> num_threads; i++)
	{
		if (i == 0) localTCB -> passLength[i] = localTCB -> sampleIndex[i];
		localTCB -> passLength[i] = localTCB -> sampleIndex[i] - localTCB -> sampleIndex[i-1];
		if (i == (localTCB -> num_threads)-1) localTCB -> passLength[i] = localTCB -> ChunkSize - localTCB -> sampleIndex[i-1];
	}
	pthread_barrier_wait(&mybarrier);


	/* Phase 4 */
	MASTER {
		for (int i = 0; i<localTCB -> num_threads; i++)
		{
			for (int j = 0; j<localTCB -> num_threads; j++)
			{
			    // each temp merge space  = localTCB[i].tmpMergeSpace[j]
                // each cpy start = localTCB[j].Chunk[localTCB[j].eachStartIndex[i]]
                // each cpy length = localTCB[j].passLength[i] * sizeof(long int)
				localTCB[i].tmpMergeSpace[j] = (long int*) malloc(sizeof(long int)*localTCB[j].passLength[i]);
				localTCB[i].mergeLength[j] = localTCB[j].passLength[i];
				memcpy(localTCB[i].tmpMergeSpace[j], &(localTCB[j].Chunk[localTCB[j].eachStartIndex[i]]), (localTCB[j].passLength[i]) * sizeof(long int));
			}
			localTCB[i].resultArr = (long int *) malloc(sizeof(long int)*sumTotal(localTCB[i].mergeLength, localTCB -> num_threads));
		}
	}
	pthread_barrier_wait(&mybarrier);
    multimerge(localTCB->tmpMergeSpace,localTCB->mergeLength,localTCB -> num_threads,localTCB->resultArr);
    pthread_barrier_wait(&mybarrier);
	//Timing



    return NULL;

} /* mySPMDMain*/