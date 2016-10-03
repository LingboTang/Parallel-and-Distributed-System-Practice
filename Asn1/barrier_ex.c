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

#define N 100
#define THREAD_COUNT 4

pthread_barrier_t mybarrier;
int cmpfunc(const void*a, const void*b)
{
	return (*(long int*)a - *(long int*)b);
}

void* threadFn(void *id_ptr) {
    int thread_id = *(int*)id_ptr;
    int wait_sec = 1 + rand() % 5;
    sleep(wait_sec);

    pthread_barrier_wait(&mybarrier);

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

int main() {
    long int * array = (long int *) malloc(sizeof(long int)*N);
    int i;
    pthread_t ids[THREAD_COUNT];
    int short_ids[THREAD_COUNT];
    srandom(time(NULL));
	
    pthread_barrier_init(&mybarrier, NULL, THREAD_COUNT + 1);

	int chunkSize = N/THREAD_COUNT;
	//long int ** data = (long int **) malloc(sizeof(long int*)*THREAD_COUNT);

    for (i=0; i < THREAD_COUNT; i++) {
        short_ids[i] = i;
        pthread_create(&ids[i], NULL, threadFn, &short_ids[i]);
    }


    pthread_barrier_wait(&mybarrier);

    for (i=0; i < THREAD_COUNT; i++) {
        pthread_join(ids[i], NULL);
    }

    pthread_barrier_destroy(&mybarrier);

	for (i = 0; i < N; i++)
    {
        array[i] = random();
    }

	/*for (i = 0; i < THREAD_COUNT; i++)
	{
		long int *subArr = (long int*) malloc(sizeof(long int)*chunkSize);
		memcpy(subArr,&array[i*chunkSize], chunkSize*sizeof(long int)+1);
		//memcpy(data[i], subArr, THREAD_COUNT*sizeof(long int*)+1);
		data[i] = subArr;
		free((void*)subArr);
	}*/
	

	/*for (i = 0; i < THREAD_COUNT; i++)
	{
		printf("Array %d: \n",i);
		for(int j =0;j< chunkSize; j++)
		{
			if (j == 0 ) {printf("[ ");}
			printf("%ld ",data[i][j]);
			if (j==chunkSize-1) {printf("]\n");}
		}		
	}*/

	printf("Before Sorting: \n");
	clock_t begin = clock();
	qsort(array,N,sizeof(long int),cmpfunc);
	clock_t end = clock();
	double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
	printf("After Sorting: \n");
	printf("time spent: %f\n",time_spent);

	free((void *) array);
	/*for (i = 0; i < THREAD_COUNT; i++)
	{
		free((void*)data[i]);
	}
	free((void *) data);*/

    return 0;
}
