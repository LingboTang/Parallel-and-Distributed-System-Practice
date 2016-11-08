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

void swap(MinHeapNode *x, MinHeapNode *y);
void MinHeapify(MinHeap mh,int i);
MinHeapNode getMin(MinHeap mh);
void replaceMin(MinHeap mh, MinHeapNode mhn);
long int* mergeArrays(long int **array, int k, int *sizes);