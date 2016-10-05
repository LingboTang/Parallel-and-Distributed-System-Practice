
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void merge(long int *left, int llength, long int *right, int rlength)
{
	/* Temporary memory locations for the 2 segments of the array to merge. */
	long int *ltmp = (long int *) malloc(llength * sizeof(long int));
	long int *rtmp = (long int *) malloc(rlength * sizeof(long int));

	/*
	 * Pointers to the elements being sorted in the temporary memory locations.
	 */
	long int *ll = ltmp;
	long int *rr = rtmp;

	long int *result = left;

	/*
	 * Copy the segment of the array to be merged into the temporary memory
	 * locations.
	 */
	memcpy(ltmp, left, llength * sizeof(long int));
	memcpy(rtmp, right, rlength * sizeof(long int));

	while (llength > 0 && rlength > 0) {
		if (*ll <= *rr) {
			/*
			 * Merge the first element from the left back into the main array
			 * if it is smaller or equal to the one on the right.
			 */
			*result = *ll;
			++ll;
			--llength;
		} else {
			/*
			 * Merge the first element from the right back into the main array
			 * if it is smaller than the one on the left.
			 */
			*result = *rr;
			++rr;
			--rlength;
		}
		++result;
	}
	/*
	 * All the elements from either the left or the right temporary array
	 * segment have been merged back into the main array.  Append the remaining
	 * elements from the other temporary array back into the main array.
	 */
	if (llength > 0)
		while (llength > 0) {
			/* Appending the rest of the left temporary array. */
			*result = *ll;
			++result;
			++ll;
			--llength;
		}
	else
		while (rlength > 0) {
			/* Appending the rest of the right temporary array. */
			*result = *rr;
			++result;
			++rr;
			--rlength;
		}

	/* Release the memory used for the temporary arrays. */
	free(ltmp);
	free(rtmp);
}

int main()
{
	/*int left[4] = {0,1,2,9};
	int right[2] = {7,8};
	merge(left, 4, right, 2);*/
	long int array[3][3] = {{0,1,2},{7,8,9},{3,4,5}};
	int length[3] = {3,3,3};
	//long int left[4] = {0,1,2,9};
	//long int right[2] = {7,8};
	int len = 3;
	//int finalCount = 0;
	/*while (finalCount < 2)
	{
		merge(array )
	}*/
	int finalCount = 2;
	while (finalCount > 0)
	{
		merge(array[0],len,array[finalCount],3);
		finalCount--;
		len = len+3;
	}
	/*for (int i = 0; i<3; i++)
	{
		merge(array[0],len,array[i+1],3);
		len = len + i*3;
	}*/
	//merge(array[0],3,array[1],3);
	//merge(array[0],6,array[2],3);
	for (int i=0; i<9;i++)
	{
		printf("%ld ",array[0][i]);
	}
	printf("\n");
	return 0;

}
