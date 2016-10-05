#include <stdio.h>
#include <stdlib.h>

int partition(int *array, int pivot, int size)
{
	int stored_index = size-1;
	for (int i = size; i>0; i--)
	{
		if (array[i] > pivot)
		{
			--stored_index;
		}	
	}
	return stored_index;
}

int *multiplePartition(int *array, int * pivot_array, int size, int size2)
{
	int *stored_index_array = (int *) malloc(sizeof(int)*size2);
	for (int i = 0; i < size2; i++)
	{
		int stored_index = 0;
		stored_index = partition(array,pivot_array[i],size);
		stored_index_array[i] = stored_index;
	}
	return stored_index_array;
}

int main()
{
	int *mystored_index_array = (int *) malloc(sizeof(int)*2);
	int pivot_array[2] = {10,22};
	int array[12]= {0,1,2,9,16,17,24,25,27,28,30,33};
	int array2[12] = {7,8,11,12,13,18,19,21,23,29,34,35};
	int array3[12] = {3,4,5,6,10,14,15,20,22,26,31,32};
	int ind = partition(array, 10, 12);
	mystored_index_array = multiplePartition(array,pivot_array, 12,2);
	for(int i =0; i< 2; i++)
	{
		printf("%d \n",mystored_index_array[i]);
	}
	printf("%d \n", ind);
	return 0;
}
