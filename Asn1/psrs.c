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
	long int **passChunks;
	int *passLength;
	long int *returnArray;
	int returnLength;
	long int **tempChunks;
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
void* threadFn4(void * chunkD);
void merge(long int *left, int llength, long int *right, int rlength);

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
		mythrD[i].tempChunks = (long int **) malloc(sizeof(long int*)*ps);
		mythrD[i].indexGroup = (int**) malloc(sizeof(int*)*ps);
		mythrD[i].passChunks = (long int **) malloc(sizeof(long int*)*ps);
		mythrD[i].passLength = (int *)malloc(sizeof(int)*ps);
		for (int j = 0; j<ps; j++)
		{
			mythrD[i].indexGroup[j] = (int *) malloc(sizeof(int)*2);
		}
		mythrD[i].pid = i;
		mythrD[i].n = numbers;
		mythrD[i].ps = ps;
		mythrD[i].returnLength = 0;
 	}
	

	long int * array = (long int *) malloc(sizeof(long int)*numbers);
	long int * result = (long int *) malloc(sizeof(long int)*numbers);
	
	pthread_t ids[ps];

	srandom(time(NULL));
	
	pthread_barrier_init(&mybarrier, NULL, ps + 1);

	int chunkSize = numbers/ps;
	long int ** data = (long int **) malloc(sizeof(long int*)*ps);
	long int * g_samples = (long int *) malloc(sizeof(long int)*(ps*ps));

	for (i = 0; i < numbers; i++)
	{
        	array[i] = random();
    }


	clock_t begin1 = clock();
	/*Phase 1*/
	for (i = 0; i < ps; i++)
	{
		data[i] = (long int*) malloc(sizeof(long int)*chunkSize);
		memcpy(data[i],&array[i*chunkSize], chunkSize*sizeof(long int));
		mythrD[i].chunk = data[i];
	}
	clock_t end1 = clock();	
	double time_spent1 = (double)(end1 - begin1) / CLOCKS_PER_SEC;
	printf("time spent 1: %f\n",time_spent1);	

	for (i=0; i < ps; i++) {
        pthread_create(&ids[i], NULL, threadFn1, (void*)&(mythrD[i]));
    }

	/*barrier 1*/
	pthread_barrier_wait(&mybarrier);

	for (i=0; i < ps; i++) {
		pthread_join(ids[i], NULL);
   	}

	/*Phase 2*/
	clock_t begin2 = clock();
	for (i = 0; i < ps; i++) {
		memcpy(&g_samples[i*ps], mythrD[i].sample, ps*sizeof(long int));
	}

	qsort(g_samples,ps*ps,sizeof(long int),cmpfunc);
	clock_t end2 = clock();	
	double time_spent2 = (double)(end2 - begin2) / CLOCKS_PER_SEC;
	printf("time spent 2: %f\n",time_spent2);


	for(i = 0; i< ps; i++)
	{
		for (int j = 1; j<ps; j++)
		{
			mythrD[i].pivotArray[j-1] = g_samples[j*ps];	
		}
	}

	/*Phase 3*/
	clock_t begin3 = clock();
	for (i = 0; i < ps; i++)
	{
		pthread_create(&ids[i],NULL,threadFn3,(void*)&(mythrD[i]));
	}
	
	/*Barrier 3*/
	pthread_barrier_wait(&mybarrier);

	for (i=0; i < ps; i++) {
		pthread_join(ids[i], NULL);
   	}
	clock_t end3 = clock();
	double time_spent3 = (double)(end3 - begin3) / CLOCKS_PER_SEC;
	printf("time spent 3: %f\n",time_spent3);	


	/*Phase 4*/
	clock_t begin4 = clock();
	for (i = 0; i<ps; i++)
	{
		for(int j = 0; j<ps; j++)
		{
			int subsize = mythrD[i].indexGroup[j][1]-mythrD[i].indexGroup[j][0]+1;
			int start = mythrD[i].indexGroup[j][0];
			mythrD[i].tempChunks[j] = (long int*) malloc(sizeof(long int)*subsize);
			memcpy(mythrD[i].tempChunks[j], &mythrD[i].chunk[start], subsize*sizeof(long int));
		}
	}
	
	for (i = 0; i<ps; i++)
	{
		for (int j = 0; j<ps; j++)
		{
			mythrD[i].passLength[j] = mythrD[j].indexGroup[i][1]-mythrD[j].indexGroup[i][0]+1;
			mythrD[i].passChunks[j] = mythrD[j].tempChunks[i];
		}
	}

	for (i = 0; i<ps; i++)
	{
		for (int j = 0; j<ps; j++)
		{
			mythrD[i].returnLength += mythrD[i].passLength[j];
		}
	}

	for (i = 0; i<ps; i++)
	{
		mythrD[i].returnArray = (long int *) malloc(sizeof(long int)*mythrD[i].returnLength);
	}
	
	/*Thread function*/
	for (i = 0; i < ps; i++)
	{
		pthread_create(&ids[i],NULL,threadFn4,(void*)&(mythrD[i]));
	}
	
	/*Barrier 4*/
	pthread_barrier_wait(&mybarrier);

	for (i=0; i < ps; i++) {
		pthread_join(ids[i], NULL);
   	}	

	
	/*Phase final*/

	pthread_barrier_destroy(&mybarrier);
	int tmpLen =0;
	for(int i = 0; i<ps; i++)
	{
		memcpy(&result[i*chunkSize],mythrD[i].returnArray,chunkSize*sizeof(long int));
	}
	clock_t end4 = clock();
	double time_spent4 = (double)(end4 - begin4) / CLOCKS_PER_SEC;
	printf("time spent 4: %f\n",time_spent4);
	
	

	free((void *) array);
	free(result);
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
			free(mythrD[i].tempChunks[j]);
			free(mythrD[i].passChunks[j]);
		}
		free(mythrD[i].indexGroup);
		free(mythrD[i].passLength);
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
	pthread_barrier_wait(&mybarrier);
	qsort(mychunkD.chunk,chunkSize,sizeof(long int),cmpfunc);
	for (int i = 0; i < sampleSize; i++)
	{
		int sample = mychunkD.chunk[i*off_set];
		mychunkD.sample[i] = sample;
	}
	return NULL;
}

void* threadFn3(void * chunkD) {
	thrD mychunkD = *(thrD *) chunkD;
	int chunkSize = mychunkD.n/mychunkD.ps;
	pthread_barrier_wait(&mybarrier);
	multiplePartition(mychunkD.chunk, mychunkD.pivotArray, mychunkD.sampleIndex,mychunkD.indexGroup, chunkSize, mychunkD.ps-1, mychunkD.ps);
	return NULL;
}

void* threadFn4(void * chunkD) {
	thrD mychunkD = *(thrD *) chunkD;
	int chunkSize = mychunkD.n/mychunkD.ps;
	pthread_barrier_wait(&mybarrier);
	memcpy(mychunkD.returnArray,mychunkD.passChunks[0],mychunkD.passLength[0]);
	int tmpLen = 0;
	for (int i = 0; i<mychunkD.ps; i++)
	{
		memcpy(&mychunkD.returnArray[tmpLen],mychunkD.passChunks[i],sizeof(long int)*mychunkD.passLength[i]);	
		tmpLen = tmpLen+mychunkD.passLength[i];
	}
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
			indexGroup[i][0] = stored_index_array[i-1]+1;
			indexGroup[i][1] = size-1;
		}
		else
		{
			indexGroup[i][0] = stored_index_array[i-1]+1;
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

/*
 * Merge Algorithm got from:
 * https://github.com/markwkm/mergesort/blob/master/mergesort.c
 */

void merge(long int *left, int llength, long int *right, int rlength)
{
	long int *ltmp = (long int *) malloc(llength * sizeof(long int));
	long int *rtmp = (long int *) malloc(rlength * sizeof(long int));

	long int *ll = ltmp;
	long int *rr = rtmp;

	long int *result = left;

	memcpy(ltmp, left, llength * sizeof(long int));
	memcpy(rtmp, right, rlength * sizeof(long int));

	while (llength > 0 && rlength > 0) {
		if (*ll <= *rr) {
			*result = *ll;
			++ll;
			--llength;
		} else {
			*result = *rr;
			++rr;
			--rlength;
		}
		++result;
	}
	if (llength > 0)
		while (llength > 0) {
			*result = *ll;
			++result;
			++ll;
			--llength;
		}
	else
		while (rlength > 0) {
			*result = *rr;
			++result;
			++rr;
			--rlength;
		}

	free(ltmp);
	free(rtmp);
}


int cmpfunc(const void*a, const void*b)
{
	return (*(long int*)a - *(long int*)b);
}