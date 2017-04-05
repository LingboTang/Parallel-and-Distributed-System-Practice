#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define NUM_THREADS 4

static double ** matrixA;
static double ** matrixB;
static double ** matrixC;

static int d2_size;

void * MatAddThread(void * threadId)
{
    int tid;
    tid = (int) threadId;
    printf("Hello from thread %d\n", tid);

    int i;

    for (i = 0; i < d2_size; i++)
    {
        matrixC[tid][i] = matrixA[tid][i] + matrixB[tid][i];
    }

    pthread_exit(NULL);

}

int main(int argc, char ** argv)
{
    pthread_t threadList[NUM_THREADS];

    int return_code;
    int i;
    int j;

    printf("Enter the size of the second dimension of dimension of the matirx: ");

    scanf("%d", &d2_size);
    matrixA = (double **) malloc(sizeof(double*)*NUM_THREADS);
    matrixB = (double **) malloc(sizeof(double*)*NUM_THREADS);
    matrixC = (double **) malloc(sizeof(double*)*NUM_THREADS);

    for(i = 0; i< NUM_THREADS; i++)
    {
        matrixA[i] = (double *) malloc(sizeof(double)*d2_size);
        matrixB[i] = (double *) malloc(sizeof(double)*d2_size);
        matrixC[i] = (double *) malloc(sizeof(double)*d2_size);
    }

    for(i = 0; i < NUM_THREADS; i++)
    {
        for (j = 0; j< d2_size; j++)
        {
            matrixA[i][j] = (double) i;
            matrixB[i][j] = (double) i;
        }
    }

    for(i=0; i< NUM_THREADS; i++)
    {
        printf("From main creating thread %d\n", i);
        return_code = pthread_create(&threadList[i],NULL,MatAddThread,(void*)((long) i));
        if (return_code != NULL)
        {
            printf("The return code from thread %d is %d\n", i, return_code);
            exit(-1);
        }
    }

    for(i = 0; i<NUM_THREADS; i++)
    {
        return_code = pthread_join(threadList[i], NULL);
        if(return_code != NULL)
        {
            printf("Unable to join thread %d\n", i);
            exit(-1);
        }
    }

    for (i=0; i<NUM_THREADS; i++)
    {
        for(j=0; j<d2_size; j++)
        {
            printf("matrixC[%d][%d] = %lf\n", i, j, matrixC[i][j]);
        }
    }

    for (int i = 0; i < NUM_THREADS; i++)
    {
        free((void*) matrixA[i]);
        free((void*) matrixB[i]);
        free((void*) matrixC[i]);
    }

    free((void*) matrixA);
    free((void*) matrixB);
    free((void*) matrixC);

    pthread_exit(NULL);
    return 0;

}