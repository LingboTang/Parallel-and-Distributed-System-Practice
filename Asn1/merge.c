
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void merge(int *left, int llength, int *right, int rlength)
{
	/* Temporary memory locations for the 2 segments of the array to merge. */
	int *ltmp = (int *) malloc(llength * sizeof(int));
	int *rtmp = (int *) malloc(rlength * sizeof(int));

	/*
	 * Pointers to the elements being sorted in the temporary memory locations.
	 */
	int *ll = ltmp;
	int *rr = rtmp;

	int *result = left;

	/*
	 * Copy the segment of the array to be merged into the temporary memory
	 * locations.
	 */
	memcpy(ltmp, left, llength * sizeof(int));
	memcpy(rtmp, right, rlength * sizeof(int));

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
	int left[4] = {0,1,2,9};
	int right[2] = {7,8};
	merge(left, 4, right, 2);
	for (int i=0; i<6;i++)
	{
		printf("%d ",left[i]);
	}
	printf("\n");
	return 0;

}
