#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

int cmpfunc(const void*a, const void*b)
{
	return (*(long int*)a - *(long int*)b);
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

int main(int argc, char**argv) {
	
	if (argc != 2)
	{
		fprintf(stderr, "error: Not enough info!\n");
		exit(EXIT_FAILURE);
	}
	int numbers = atoi(argv[1]);
	int i;

	long int * array = (long int *) malloc(sizeof(long int)*numbers);

	srandom(time(NULL));

	for (i = 0; i < numbers; i++)
	{
        	array[i] = random();
    }

	clock_t begin = clock();
	qsort(array,numbers,sizeof(long int),cmpfunc);
	clock_t end = clock();
	double time_spent = (double) (end-begin) / CLOCKS_PER_SEC;
	
	//printArr(array,numbers);
	printf("time spent: %f\n",time_spent);

	free((void *) array);	
	return 0;

}

