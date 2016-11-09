#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

void multimerge(
    long int ** arrays,      // arrays holding the data
    int * arraysizes,    // sizes of the arrays in `arrays`
    int number_of_arrays,            // number of arrays
    long int * output               // pointer to output buffer
){
    int i = 0;       // output cursor
    int j = 0;       // index for minimum search
    int min;         // minimum in this iteration
    int minposition; // position of the minimum

    // cursor for the arrays
    long int * cursor = calloc(number_of_arrays,sizeof(long int));

    if(cursor == NULL) return;

    while(1){
        min = INT_MAX;
        minposition = -1; // invalid position

        // Go through the current positions and get the minimum
        for(j = 0; j < number_of_arrays; ++j){

            if(cursor[j] < arraysizes[j] &&  // ensure that the cursor is still valid
               arrays[j][cursor[j]] < min){  // the element is smaller
                min = arrays[j][cursor[j]];  // save the minimum ...
                minposition = j;             // ... and its position
            }
        }

        // if there is no minimum, then the position will be invalid

        if(minposition == -1)
            break;

        // update the output and the specific cursor            
        output[i++] = min;
        cursor[minposition]++;
    }
    free(cursor);
}

int main()
{
    int i = 0;
    long int test1[5] = {23, 24, 25, 33, 51};
    long int test2[5] = {21, 34, 44, 50, 62};
    long int test3[5] = {34, 36, 41, 44, 46};
    long int test4[5] = {30, 31, 32, 35, 40};
    long int test5[5] = {54, 56, 57, 58, 60};
    long int test6[5] = {31, 33, 36, 51, 52};
    long int test7[5] = {44, 46, 76, 78, 79};
    long int test8[5] = {23, 33, 43, 54, 63};

    long int *test[] = {test1, test2, test3, test4, test5, test6, test7, test8};
    int testsizes[] = {5,5,5,5,5,5,5,5};

    long int output[40];

    multimerge(test,testsizes,8,output);

    while(i < 30){
        printf("%ld\n",output[i++]);
    }    

    return 0;
}