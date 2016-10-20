#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <math.h>
#include <time.h>



typedef struct MinHeapNode
{
    long int element;
    int i;
    int j;
} MinHeapNode;

typedef struct MinHeap
{
    MinHeapNode *harr;
    int heap_size;
} MinHeap;

void swap(MinHeapNode *x, MinHeapNode *y)
{
    MinHeapNode temp = *x;
    *x = *y;
    *y = temp;
}

void MinHeapify(MinHeap mh,int i)
{
    int l = 2*i+1;
    int r = 2*i+2;
    int smallest = i;
    if (l < mh.heap_size && mh.harr[l].element < mh.harr[i].element)
        smallest = l;
    if (r < mh.heap_size && mh.harr[r].element < mh.harr[smallest].element)
        smallest = r;
    if (smallest != i)
    {
        swap(&(mh.harr[i]), &(mh.harr[smallest]));
        MinHeapify(mh, smallest);
    }
}

MinHeapNode getMin(MinHeap mh)
{
    return mh.harr[0];
}

void replaceMin(MinHeap mh, MinHeapNode mhn)
{
    mh.harr[0] = mhn; 
    MinHeapify(mh,0);
}

long int* mergeArrays(long int **array, int k, int *sizes)
{
    int finalsize = 0;
    for (int count = 0; count < k; count++)
    {
        finalsize = finalsize + sizes[count];
    }
    long int *output = (long int *) malloc(sizeof(long int)*finalsize);
    MinHeapNode *harr = (MinHeapNode *) malloc(sizeof(MinHeapNode)*k);
    for (int i = 0; i< k; i++)
    {
        harr[i].element = array[i][0];
        harr[i].i = i;
        harr[i].j = 1;
    }

    MinHeap hp;
    hp.harr = harr;
    hp.heap_size = k;
    int n = (k-1)/2;
    while (n >=0)
    {
        MinHeapify(hp,n);
        n--;
    }

    

    int w = 0;
    int count = 0;
    while(w < finalsize)
    {
        MinHeapNode root = getMin(hp);
        output[w] = root.element;

        w = w+1;
        if (root.j < sizes[count])
        {
            root.element = array[root.i][root.j];
            root.j+=1;
        }
        else {
            count = count + 1;
            root.element = LONG_MAX;
        }
        replaceMin(hp,root);
    }

    return output;

}

void printArr(long int * Arr,int size)
{
    for (int i = 0; i<size; i++)
    {
        printf("%ld ",Arr[i]);
    }
    printf("\n");
}

int main() {
    srand(time(NULL));
    int sizes[3] = {3,4,3};
    long int **array = (long int **) malloc(sizeof(long int*)*3);
    long int A[3] = {0,1,2};
    long int B[4] = {7,8,9,10};
    long int C[3] = {4,5,6};
    for (int i = 0; i<3; i++)
    {
        int local_size = sizes[i];
        array[i] = (long int *) malloc(sizeof(long int)*local_size);
    }
    array[0] = A;
    array[1] = B;
    array[2] = C;
    for (int i = 0; i < 3; ++i)
    {
        printArr(array[i],sizes[i]);
    }
    int finalsize = 0;
    for (int i = 0; i < 3; i++)
    {
        finalsize += sizes[i];
    }
    long int * output = (long int *) malloc(sizeof(long int)*finalsize);
    output = mergeArrays(array, 3, sizes);
    for (int i =0; i<10; i++)
    {
        printf("%ld ",output[i]);
    }
    printf("\n");
    for (int i = 0; i<3; i++)
    {
        free(array[i]);
    }
    free(array);
    free(output);
    return 0;
}