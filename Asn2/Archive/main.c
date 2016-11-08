#include "psrs.h"


int main(int argc, char ** argv)
{
    /* Global Variables */
    char * outputFilename;
    FILE * outfp;
    int N, size, rank, thrN;
    char hname[256];


    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WOLRD, &size);
    MPI_Comm_rank(MPI_COMM_WOLRD, &rank);
    /*if (rank == MASTER) {
        fprintf()
    }*/    

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
    long int * randArray = (long int *) malloc(sizeof(long int)*N);
    long int * subRand = (long int *) malloc(sizeof(long int)*N/thrN);
    long int ** subRands = (long int **) malloc(sizeof(long int*)*thrN);
    for (int i = 0; i < thrN; i++)
    {
        subRands[i] = (long int *) malloc(sizeof(long int) * N/thrN);
    }
    long int * samples = (long int*) malloc(sizeof(long int) * thrN);
    long int * samplePivot = (long int *) malloc(sizeof(long int)*(thrN*thrN));

    srandom(MYSEED);

    for (int i = 0; i < N; i++)
    {
        randArray[i] = random()%1000;
    }



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
    for (int i = 0; i<size; i++)
    {
        if (i == rank)
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