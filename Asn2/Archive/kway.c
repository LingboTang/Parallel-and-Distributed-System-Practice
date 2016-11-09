#include "kway.h"


struct chunks {
    int storedi;
    int i;
    long int storedvalue;
};

int multimerge(int * startInd[], const int Len[], const int NumThr, 
               long int sorted[], const int newArrayLength) 
{

    priority priorities;
    for (int i = 0; i < NumThr; i++) {
        if (Len[i]> 0) {
            priorities.push(chunks,)
        }
    }
}