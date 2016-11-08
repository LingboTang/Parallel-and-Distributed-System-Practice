#include "debug.h"

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

int isSorted(long int * arr, int size) {
    for (int i = 0; i<size -1; i++) {
        if (arr[i] > arr[i+1]) {
            return 0;
        }
    } 

    return 1;
}