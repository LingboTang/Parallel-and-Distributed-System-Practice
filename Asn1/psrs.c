#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <malloc.h>
#include <pthread.h>
#include <time.h>
#include <unistd.h>

#define N 1000
#define X 200
#define THREAD_COUNT 4

pthread_barrier_t mybarrier;

/*Compare function for qsort*/
int cmpfunc(const void*a, const void*b)
{
	return (*(int*)a - *(int*)b);
}

void printArr(int* arr, int size)
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


void* threadFunc(void * id_ptr, int*partition)
{
	int thread_id = *(int*)id_ptr;
	int wait_sec = 1+ rand()%5;
	sleep(wait_sec);
	printf("thread %d: Me!\n",thread_id);
	pthread_barrier_wait(&mybarrier);
	
	return NULL;
}


int main()
{
	
    int * array = (int *) malloc(sizeof(int)*N);
    int i;
	int id;
	int j;
	pthread_t ids[THREAD_COUNT];
	int short_ids[THREAD_COUNT];
	srand(time(NULL));
	pthread_barrier_init(&mybarrier,NULL, THREAD_COUNT+1);

	for (i = 0; i < THREAD_COUNT; i++)
	{
		short_ids[i]=i;
		pthread_create(&ids[i],NULL,threadFunc,&short_ids[i]);
	}

	printf("It's main()\n");

	pthread_barrier_wait(&mybarrier);

	for(i = 0; i < THREAD_COUNT;i++)
	{
		pthread_join(ids[i],NULL);
	}

	pthread_barrier_destroy(&mybarrier);
	
    for (i = 0; i < N; i++)
    {
        array[i] = rand()%X;
    }

	printf("Before Sorting: \n");
	printArr(array, N);
	qsort(array,N,sizeof(int),cmpfunc);
	printf("After Sorting: \n");
	printArr(array, N);

	free((void *) array);

	return 0;
}
