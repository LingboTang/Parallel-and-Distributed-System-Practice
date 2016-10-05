#include <stdio.h>
#include <stdlib.h>

int cmpfunc(const void*a, const void*b)
{
	return (*(long int*)a - *(long int*)b);
}

int partition(long int *array,long int pivot, int size)
{
	int stored_index = 0;
	for (int i = 0; i<size; i++)
	{
		if (array[i] < pivot)
		{
			++stored_index;
		}	
	}
	return stored_index-1;
}

void multiplePartition(long int *array,long int * pivot_array, int* stored_index_array, int** index_group, int size, int size2, int size3)
{
	for (int i = 0; i < size2; i++)
	{
		int stored_index = 0;
		stored_index = partition(array,pivot_array[i],size);
		stored_index_array[i] = stored_index;
	}
	for (int i = 0; i < size3; i++)
	{
		if (i == 0)
		{
			index_group[i][0] = 0;
			index_group[i][1] = stored_index_array[i];
		}
		else if (i == size3-1)
		{
			index_group[i][0] = stored_index_array[i];
			index_group[i][1] = size-1;
		}
		else
		{
			index_group[i][0] = stored_index_array[i-1];
			index_group[i][1] = stored_index_array[i];
		}
	}
}

int main()
{
	int **intervals = (int **) malloc(sizeof(int *)*4);
	int **myintervals = (int **) malloc(sizeof(int *)*3);
	int* mystored_index_array = (int *) malloc(sizeof(int)*2);
	for(int i = 0; i < 4; i++)
	{
		intervals[i] = (int *) malloc(sizeof(int)*2);
	}
	for(int i = 0; i < 3; i++)
	{
		myintervals[i] = (int *) malloc(sizeof(int)*2);
	}
	long int array[16] = {1,67,2,6,8,5,9,34,25,57,22,546,89,26,11,12};
	long int array3[12] = {3,4,5,6,10,14,15,20,22,26,31,32};
	long int mypivot[2] = {10,22};

	multiplePartition(array3,mypivot, mystored_index_array, myintervals, 12, 2, 3);
	for (int i = 0; i<3; i++)
	{
		for (int j =0; j<2;j++)
		{
			printf("%d ",myintervals[i][j]);
		}
		printf("\n");
	}
	printf("\n");
	
	
	qsort(array, 16, sizeof(long int), cmpfunc);
	for(int i = 0; i<16; i++)
	{
		printf("%ld ",array[i]);
	}
	printf("\n");
	long int pivot[3] = {3,20,100};
	int* stored_index_array = (int *) malloc(sizeof(int)*3);
	multiplePartition(array,pivot, stored_index_array, intervals, 16, 3, 4);
	printf("Stored_index_array!\n");	
	for(int i = 0; i< 3; i++)
	{
		printf("%d ",stored_index_array[i]);
	}
	printf("\n");
	for (int i = 0; i<4; i++)
	{
		for (int j =0; j<2;j++)
		{
			printf("%d ",intervals[i][j]);
		}
		printf("\n");
	}
	printf("\n");
	return 0;
}
