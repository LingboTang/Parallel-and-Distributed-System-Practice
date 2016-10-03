#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <string.h>
#include <time.h>

#define N 100
#define THREAD_COUNT 4


int main(){
	long int * array = (long int *) malloc(sizeof(long int) *N);
	int i;
	int chunkSize = N/THREAD_COUNT;
	long int ** data = (long int **) malloc(sizeof(long int*) *THREAD_COUNT);
	srandom(time(NULL));
	for (i = 0; i< N; i++)
	{
		array[i] = random();
	}

	for (i = 0; i< THREAD_COUNT; i++)
	{	
		data[i] = malloc(sizeof(long int) * chunkSize);
		memcpy(data[i], &array[i*chunkSize], chunkSize*sizeof(long int));
	}

	for (i = 0; i < THREAD_COUNT; i++)
	{
		printf("Array %d: \n",i);
		for(int j =0;j< chunkSize; j++)
		{
			if (j == 0 ) {printf("[ ");}
			printf("%ld ",data[i][j]);
			if (j==chunkSize-1) {printf("]\n");}
		}		
	}
	
	free((void *) array);
	for (i = 0; i < THREAD_COUNT; i++)
	{
		free((void*)data[i]);
	}
	free((void *) data);


}
