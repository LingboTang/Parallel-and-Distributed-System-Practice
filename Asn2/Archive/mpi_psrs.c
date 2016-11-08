#include "psrs.h"

#define MASTER 0
#define MYSEED 23478237

static long int * generateArray(long int * randArray,int N) {
    srandom(MYSEED);
    randArray = (long int *) malloc(sizeof(long int)*N);
    for (int i = 0; i < N; i++)
    {
        randArray[i] = random()%1000;
    }
    return randArray;
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

int cmpfunc(const void*a, const void*b)
{
    return (*(long int*)a - *(long int*)b);
}

/*void phase1(long int * origin, long int*sub, long int**subs, long int *samplePivot, int oriSize, int numThr, int myiter) 
{
    memset(sub, 0, oriSize/numThr * sizeof(long int));
    MPI_Scatter(origin, oriSize/numThr, MPI_LONG, sub, oriSize/numThr, MPI_LONG, MASTER, MPI_COMM_WORLD);
    qsort(sub, oriSize/numThr, sizeof(long int), cmpfunc);
    subs[myiter] = sub;
}*/


int main(int argc, char *argv[])
{

    long int * randArray = NULL;
    /* Global Variables */
    MPI_Init(&argc, &argv);
    int N, thrN, taskid, iter;
    char * outputFilename;
    FILE * outfp;

    /* N, P and output get from Command line */
    if (argc < 4)
    {
        fprintf(stderr,"usage: ./mpi_psrs <# of Keys> <# of threads> <Outputfile> \n");
        exit(0);
    }
    N = atoi(argv[1]);
    thrN = atoi(argv[2]);
    outputFilename = argv[3];
    outfp = fopen(outputFilename,"w");

    /* Init the test array*/
    //long int * randArray = (long int *) malloc(sizeof(long int)*N);
    long int * subRand = (long int *) malloc(sizeof(long int)*N/thrN);
    long int ** subRands = (long int **) malloc(sizeof(long int*)*thrN);
    for (int i = 0; i < thrN; i++)
    {
        subRands[i] = (long int *) malloc(sizeof(long int) * N/thrN);
    }
    long int * samples = (long int*) malloc(sizeof(long int) * thrN);
    long int * samplePivot = (long int *) malloc(sizeof(long int)*(thrN*thrN));

    randArray = generateArray(randArray,N);

    MPI_Comm_size(MPI_COMM_WORLD, &iter);
    MPI_Comm_rank(MPI_COMM_WORLD,&taskid);

    /* Start */

    memset(subRand, 0, N/thrN * sizeof(long int));
    memset(samples, 0, thrN * sizeof(long int));
    //if (taskid == MASTER)
    //{
    MPI_Scatter(randArray, N/thrN, MPI_LONG, subRand, N/thrN, MPI_LONG, MASTER, MPI_COMM_WORLD);
    //}
    qsort(subRand, N/thrN, sizeof(long int), cmpfunc);
    for (int j = 0; j<thrN; j++)
    {
        samples[j] = subRand[j*N/(thrN*thrN)];
    }
    printArr(samples,thrN);
    for (int i = 0; i<iter; i++)
    {
        if (i == taskid)
        {
            memcpy(&samplePivot[taskid*thrN],samples,thrN*sizeof(long int));
        }
    }
    printArr(samplePivot,thrN*thrN);

    MPI_Finalize();    
    free(randArray);
    free(subRand);
    for(int i = 0; i<thrN; i++)
    {
        free(subRands[i]);
    }
    free(subRands);
    free(samples);
    free(samplePivot);
    fclose(outfp);
    return 0;   
}