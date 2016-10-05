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



pthread_barrier_t mybarrier;

typedef struct threadData{
	long int *chunk;
	long int *sample;
	long int *pivotArray;
	long int **tempChunk;
	int *sampleIndex;
	int **indexGroup;
	int pid;
	int n;
	int ps;
} thrD;

int partition(long int *array,long int pivot, int size);
void multiplePartition(long int *array, long int * pivot_array, int* stored_index_array, int**indexGroup, int size, int size2, int size3);
int cmpfunc(const void*a, const void*b);
void printArr(long int* arr, int size);
void* threadFn1(void * chunkD);
void* threadFn3(void * chunkD);

int main(int argc, char**argv) {
	
	/*Take args*/
	if (argc != 3)
	{
		fprintf(stderr, "error: Not enough info!\n");
		exit(EXIT_FAILURE);
	}
	int numbers = atoi(argv[1]);
	int ps = atoi(argv[2]);

	/*Initialize*/
	int i;
	int allChunkSize = numbers/ps;
	int allSampleSize = ps;
	thrD *mythrD = (thrD *) malloc(sizeof(thrD)*ps);
	for (i = 0; i < ps; i++)
	{
		mythrD[i].sample = (long int *) malloc(sizeof(long int)*ps);
		mythrD[i].sampleIndex =(int *) malloc(sizeof(int)*(ps-1));
		mythrD[i].pivotArray =(long int *) malloc(sizeof(long int)*(ps-1));
		mythrD[i].tempChunk = (long int **) malloc(sizeof(long int*)*ps);
		mythrD[i].indexGroup = (int**) malloc(sizeof(int*)*ps);
		for (int j = 0; j<ps; j++)
		{
			mythrD[i].indexGroup[j] = (int *) malloc(sizeof(int)*2);
		}
		mythrD[i].pid = i;
		mythrD[i].n = numbers;
		mythrD[i].ps = ps;
 	}
	

	long int * array = (long int *) malloc(sizeof(long int)*numbers);
	//long int * pivot = (long int *) malloc(sizeof(long int)*(ps-1));
	
	pthread_t ids[ps];

	srandom(time(NULL));
	
	pthread_barrier_init(&mybarrier, NULL, ps + 1);

	int chunkSize = numbers/ps;
	long int ** data = (long int **) malloc(sizeof(long int*)*ps);
	long int * g_samples = (long int *) malloc(sizeof(long int)*(ps*ps));

	for (i = 0; i < numbers; i++)
	{
        	array[i] = random()%100;
    }


	/*Phase 1*/
	for (i = 0; i < ps; i++)
	{
		data[i] = (long int*) malloc(sizeof(long int)*chunkSize);
		memcpy(data[i],&array[i*chunkSize], chunkSize*sizeof(long int));
		mythrD[i].chunk = data[i];
	}	
	
	for (i =0; i < ps; i++)
	{
		printArr(mythrD[i].chunk, chunkSize);
	}

	for (i=0; i < ps; i++) {
        pthread_create(&ids[i], NULL, threadFn1, (void*)&(mythrD[i]));
    }

	/*barrier 1*/
	pthread_barrier_wait(&mybarrier);

	for (i=0; i < ps; i++) {
		pthread_join(ids[i], NULL);
   	}

	/*Phase 2*/
	for (i = 0; i < ps; i++) {
		memcpy(&g_samples[i*ps], mythrD[i].sample, ps*sizeof(long int));
	}

	qsort(g_samples,ps*ps,sizeof(long int),cmpfunc);


	for(i = 0; i< ps; i++)
	{
		for (int j = 1; j<ps; j++)
		{
			mythrD[i].pivotArray[j-1] = g_samples[j*ps];	
		}
	}

	/*Phase 3*/
	for (i = 0; i < ps; i++)
	{
		pthread_create(&ids[i],NULL,threadFn3,(void*)&(mythrD[i]));
	}
	
	/*Barrier 3*/
	pthread_barrier_wait(&mybarrier);

	for (i=0; i < ps; i++) {
		pthread_join(ids[i], NULL);
   	}	

	/*Debugginig phase 3*/
	printf("Gathered Samples\n");
	for (int i = 0; i < ps*ps; i++)
	{
		
		printf("%ld ",g_samples[i]);
	}
	
	printf("\nPivots\n");
	for (int j = 0; j<ps-1; j++)
	{
		printf("%ld ",mythrD[0].pivotArray[j]);	
	}
	printf("\n");

	printf("Picked Index\n");
	for (i = 0; i<ps; i++)
	{
		for (int j = 0; j<ps-1; j++)
		{
			printf("%d ",mythrD[i].sampleIndex[j]);
		}
		printf("\n");
	}
	printf("\n");

	for (i =0; i<ps; i++)
	{
		printf("This thread: \n");
		for(int j = 0; j< ps; j++)
		{
			for (int k = 0; k < ps-1; k++)
			{
				printf("%d ", mythrD[i].indexGroup[j][k]);
			}
		}
		printf("\n");
	}
	printf("\n");

	/*Phase 4*/
	/*for (i = 0; i<ps; i++)
	{
		for (int j = 0; j<ps; j++)
		{
			mythrD
		}
	}*/

	/*legacy debugging*/
	for (i =0; i < ps; i++)
	{
		printArr(mythrD[i].chunk, chunkSize);
	}
	/*Phase final*/

	pthread_barrier_destroy(&mybarrier);

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
		free(mythrD[i].pivotArray);
		free(mythrD[i].sampleIndex);
		for (int j = 0; j<ps; j++)
		{
			free(mythrD[i].indexGroup[j]);
		}
		free(mythrD[i].indexGroup);
	}
	free((void*)mythrD);
	free(g_samples);


    return 0;
}

void* threadFn1(void * chunkD) {
	thrD mychunkD = *(thrD *) chunkD;
	int off_set = mychunkD.n/(mychunkD.ps*mychunkD.ps);
	int chunkSize = mychunkD.n/mychunkD.ps;
	int sampleSize = chunkSize/off_set;
	//int wait_sec = 1 + rand() % 2;
	//sleep(wait_sec);
	pthread_barrier_wait(&mybarrier);
	qsort(mychunkD.chunk,chunkSize,sizeof(long int),cmpfunc);
	for (int i = 0; i < sampleSize; i++)
	{
		int sample = mychunkD.chunk[i*off_set];
		mychunkD.sample[i] = sample;
	}
	//sleep(wait_sec);
	return NULL;
}

void* threadFn3(void * chunkD) {
	thrD mychunkD = *(thrD *) chunkD;
	int chunkSize = mychunkD.n/mychunkD.ps;
	pthread_barrier_wait(&mybarrier);
	multiplePartition(mychunkD.chunk, mychunkD.pivotArray, mychunkD.sampleIndex,mychunkD.indexGroup, chunkSize, mychunkD.ps-1, mychunkD.ps);
	return NULL;
}

int partition(long int *array,long int pivot, int size)
{
	int stored_index = 0;
	for (int i = 0; i<size; i++)
	{
		if (array[i] <= pivot)
		{
			++stored_index;
		}	
	}
	return stored_index-1;
}

void multiplePartition(long int *array,long int * pivot_array, int* stored_index_array,int **indexGroup, int size, int size2, int size3)
{
	for (int i = 0; i < size2; i++)
	{
		int stored_index = 0;
		stored_index = partition(array,pivot_array[i],size);
		stored_index_array[i] = stored_index;
	}
	for (int i = 0; i< size3; i++)
	{
		if (i == 0)
		{
			indexGroup[i][0] = 0;
			indexGroup[i][1] = stored_index_array[i];
		}
		else if (i == size3-1)
		{
			indexGroup[i][0] = stored_index_array[i-1];
			indexGroup[i][1] = size-1;
		}
		else
		{
			indexGroup[i][0] = stored_index_array[i-1];
			indexGroup[i][1] = stored_index_array[i];
		}
	}
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

