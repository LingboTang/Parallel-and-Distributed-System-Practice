#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <string.h>
#include <malloc.h>
#include <unistd.h>
#include <limits.h>
#include <time.h>
#include <assert.h>

typedef struct ThreadControlBlock {
	long int *Chunk;
	int *passLength;
	int *sampleIndex;
	int *eachStartIndex;
	long int **tmpMergeSpace;
	long int *pivotArray;
	long int *selectedPivot;
	long int *samples;
	int *mergeLength;
	long int * resultArr;
	int pid;
	int N;
	int num_threads;
	int ChunkSize;
	int offSet;
} TCB;


int cmpfunc(const void*a, const void*b);
int sumTotal(int *arr, int size);
void printArr(long int* arr, int size);
void printArrInt(int* arr, int size);
void multimerge(long int ** arrays, int * arraysizes, int number_of_arrays, long int * output);
int binarySearch(long int *arr, int l, int r, long int x);
int isSorted(long int * arr, int size);