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

#define N 36
#define X 20
#define THREAD_COUNT 3


pthread_barrier_t mybarrier;

typedef struct threadData{
	long int *chunk;
	long int *sample;
	int pid;
	int n;
	int ps;
} thrD;

int cmpfunc(const void*a, const void*b);
void printArr(long int* arr, int size);
void* threadFn1(void * chunkD);

int main(int argc, char**argv) {
	if (argc != 3)
	{
		fprintf(stderr, "error: Not enough info!\n");
		exit(EXIT_FAILURE);
	}
	int numbers = atoi(argv[1]);
	int ps = atoi(argv[2]);
	int i;
	thrD *mythrD = (thrD *) malloc(sizeof(thrD)*ps);
	for (i = 0; i < ps; i++)
	{
		mythrD[i].pid = i;
		mythrD[i].n = numbers;
		mythrD[i].ps = ps;
 	}

	
	long int * array = (long int *) malloc(sizeof(long int)*N);
	
	pthread_t ids[ps];

	srandom(time(NULL));
	
	pthread_barrier_init(&mybarrier, NULL, ps + 1);

	int chunkSize = N/ps;
	long int ** data = (long int **) malloc(sizeof(long int*)*ps);
	long int * g_samples = (long int *) malloc(sizeof(long int)*(ps*ps));

	for (i = 0; i < N; i++)
	{
        	array[i] = rand()%X;
    }

	for (i = 0; i < ps; i++)
	{
		data[i] = (long int*) malloc(sizeof(long int)*chunkSize);
		memcpy(data[i],&array[i*chunkSize], chunkSize*sizeof(long int));
		mythrD[i].chunk = data[i];
	}	
	
	printf("Before Sorting: \n");
	for (i =0; i < ps; i++)
	{
		printArr(mythrD[i].chunk, 12);
	}

	for (i=0; i < ps; i++) {
        pthread_create(&ids[i], NULL, threadFn1, (void*)&(mythrD[i]));
    }


	pthread_barrier_wait(&mybarrier);

	for (i=0; i < ps; i++) {
		pthread_join(ids[i], NULL);
   	}
	pthread_barrier_destroy(&mybarrier);

	/*for (i = 0; i < ps; i++) {
		memcpy(&g_samples[i*ps], mythrD[i].sample, ps*sizeof(long int));
	}

	for (i = 0; i< ps*ps; i++) {
		printf("%ld ",g_samples[i]);
	}*/

	
	printf("After Sorting: \n");
	for (i =0; i < ps; i++)
	{
		printArr(mythrD[i].chunk, 12);
	}

	free((void *) array);
	for (i = 0; i < ps; i++)
	{
		free((void*)data[i]);
	}
	free((void *) data);
	for (i = 0; i < ps; i++)
	{
		free(mythrD[i].chunk);
		free(mythrD[i].sample);
	}
	free((void*)mythrD);
	free(g_samples);


    return 0;
}

void* threadFn1(void * chunkD) {
	thrD mychunkD = *(thrD *) chunkD;
	int off_set = mychunkD.n/(mychunkD.ps*mychunkD.ps);
	int chunkSize = mychunkD.n/mychunkD.ps;
	int wait_sec = 1 + rand() % 2;
	//sleep(wait_sec);
	pthread_barrier_wait(&mybarrier);
	qsort(mychunkD.chunk,chunkSize,sizeof(long int),cmpfunc);
	mychunkD.sample = (long int *) malloc(sizeof(long int)*(chunkSize/off_set));
	for (int i = 0; i < chunkSize; i++)
	{
		mychunkD.sample[i] = mychunkD.chunk[i*off_set];
	}
	//sleep(wait_sec);
	return NULL;
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

int cmpfunc(const void*a, const void*b)
{
	return (*(long int*)a - *(long int*)b);
}

