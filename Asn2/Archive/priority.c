#include <stdio.h>
#include <stdlib.h>
 
typedef struct {
    int priority;
    long int *data;
} node_t;
 
typedef struct {
    node_t *nodes;
    int len;
    int size;
} heap_t;

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
 
void push (heap_t *h, int priority, long int *data) {
    if (h->len + 1 >= h->size) {
        h->size = h->size ? h->size * 2 : 4;
        h->nodes = (node_t *)realloc(h->nodes, h->size * sizeof (node_t));
    }
    int i = h->len + 1;
    int j = i / 2;
    while (i > 1 && h->nodes[j].priority > priority) {
        h->nodes[i] = h->nodes[j];
        i = j;
        j = j / 2;
    }
    h->nodes[i].priority = priority;
    h->nodes[i].data = data;
    h->len++;
}
 
long int *pop (heap_t *h) {
    int i, j, k;
    if (!h->len) {
        return NULL;
    }
    long int *data = h->nodes[1].data;
    h->nodes[1] = h->nodes[h->len];
    h->len--;
    i = 1;
    while (1) {
        k = i;
        j = 2 * i;
        if (j <= h->len && h->nodes[j].priority < h->nodes[k].priority) {
            k = j;
        }
        if (j + 1 <= h->len && h->nodes[j + 1].priority < h->nodes[k].priority) {
            k = j + 1;
        }
        if (k == i) {
            break;
        }
        h->nodes[i] = h->nodes[k];
        i = k;
    }
    h->nodes[i] = h->nodes[h->len + 1];
    return data;
}
 
/*int main () {
    heap_t *h = (heap_t *)calloc(1, sizeof(heap_t));
    long int aa[3] = {341,512,112}; long int bb[3] = {111,41,352}; 
    long int cc[3] = {123,533,89};
    //long int*a = (long int *) calloc(2,sizeof(long int));
    //long int*b = (long int *) calloc(3,sizeof(long int));
    //long int*c = (long int *) calloc(4,sizeof(long int));
    //a = aa;
    //b = bb;
    //c = cc;
    push(h, 3, aa);
    push(h, 2, bb);
    push(h, 1, cc);
    int i,j;
    for (i = 0; i < 3; i++) {
        printArr(pop(h),3);   
    }
    return 0;
}*/