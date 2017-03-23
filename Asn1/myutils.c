#include "myutils.h"

int sumTotal(int *arr, int size)
{
    int total = 0;
    for (int i = 0; i<size; i++)
    {
        total = total+arr[i];
    }
    return total;
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

void printArrInt(int* arr, int size)
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


int cmpfunc(const void*a, const void*b)
{
	return (*(long int*)a - *(long int*)b);
}

void multimerge(long int ** arrays, int * arraysizes, int number_of_arrays, long int * output) {
    int i = 0;       
    int j = 0;       
    int min;         
    int minposition;
  
    long int * cursor = calloc(number_of_arrays,sizeof(long int));

    if(cursor == NULL)
        return;

    while(1){
        min = INT_MAX;
        minposition = -1; 

        
        for(j = 0; j < number_of_arrays; ++j){

            if(cursor[j] < arraysizes[j] && arrays[j][cursor[j]] < min){  
                min = arrays[j][cursor[j]];  
                minposition = j;             
            }
        }


        if(minposition == -1)
            break;
     
        output[i++] = min;
        cursor[minposition]++;
    }
    free(cursor);
}

int binarySearch(long int *arr, int l, int r, long int x)
{
	if (r>= l)
	{
		int mid = l + (r-l)/2;
		if (arr[mid] == x) return mid + 1;
		if (arr[mid] > x) return binarySearch(arr,l, mid-1, x);
		return binarySearch(arr, mid+1, r, x);
	}
	else {
      return l;
    }
}

int isSorted(long int * arr, int size) {
    for (int i = 0; i<size -1; i++) {
        if (arr[i] > arr[i+1]) {
            return 0;
        }
    }

    return 1;
}
