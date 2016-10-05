#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
	long int *array = (long int *) malloc(sizeof(long int)*10);
	long int *array2 = (long int *) malloc(sizeof(long int) * 10);
	for (int i = 0; i< 10; i++)
	{
		array[i] = i;
		array2[i] = 10-i-1;
	}
	for (int i = 0; i<10; i++)
	{
		printf("%ld ",array[i]);
	}
	printf("\n");
	memcpy(array,array2,10*sizeof(long int));
	for (int i = 0; i<10; i++)
	{
		printf("%ld ",array[i]);
	}
	printf("\n");
	return 0;
}
