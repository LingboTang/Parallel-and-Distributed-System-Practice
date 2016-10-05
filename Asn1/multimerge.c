#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void
merge(int *a, int *b, int *ret, int aLen, int bLen) 
{
	int i = 0, k = 0, j = 0;

	for (i = 0; i < aLen + bLen; i++) {
		if ( (j < aLen) && (k < bLen) ) {
			if (a[j] < b[k]) {
				ret[i] = a[j];
				j++;
			} else {
				ret[i] = b[k];
				k++;
			}
		} else if (j == aLen) {
			ret[i] = b[k];
			k++;
		} else {
			ret[i] = a[j];
			j++;
		}
	}

}

int *
mergePartitions(int **partitions, int *incomingPartitionSizes, int size)
{
	int *ret = NULL, *retCpy = NULL, mergedSize = 0, oldMergedSize = 0, i;

	ret = partitions[0];
	mergedSize += incomingPartitionSizes[0];
	for (i = 1; i < size; i++) {
		oldMergedSize = mergedSize;
		mergedSize += incomingPartitionSizes[i];
		retCpy = ret;
		ret = calloc(mergedSize, sizeof(int));
		merge(partitions[i], retCpy, ret, incomingPartitionSizes[i],
		    oldMergedSize);
	}
	return ret;
}



int main()
{
	int * myDD = NULL;
	int **array = (int **)malloc(sizeof(int *)*3);
	for (int i = 0; i< 3; i++)
	{
		for (int j = 0; j< 3; j++)
		{
			int k = rand()%3;
			array[i][j] = k;
		}
	}
	//int array[3][3] = {{0,1,2},{7,8,9},{3,4,5}};
	int length[3] = {3,3,3};
	myDD = mergePartitions(array, length, 3);
	for (int i = 0; i<9; i++)
	{
		printf("%d ", myDD[i]);
	}
	return 0;
}
