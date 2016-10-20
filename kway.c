
#include <stdio.h>
#include <malloc.h>

#define N 80
#define K 2            // K-way merge.#define DATAFILE "main.txt"#define TEMPFILE "temp.txt"

typedef struct node node;
typedef enum {FALSE, TRUE} bool;

struct node {
    int val;
    char s[N];
};

node buf[K];        // buffer used for merging.int  rec[K];        // record numbers of nodes in buffer.int getNRecords( char *filename ) {
    /*
     * returns no of records in file filename using size of the file.
     */
int off;
    FILE *fp = fopen( filename, "r" );
    fseek (fp, 0, SEEK_END );
    off = ftell(fp)/sizeof(node);    // no of records.
    fclose(fp);

    return off;
}

void writeToFile( char *filename, node *n ) {
    /*
     * writes record n to file filename.
     */

    FILE *fp = fopen( filename, "a" );
    fwrite( n, sizeof(node), 1, fp );
    fclose(fp);
}

void readFromFile( char *filename, node *n, int off ) {
    /*
     * reads a record at offset off from file filename into n.
     * off is number of records before the record in the file (NOT bytes).
     * off starts from 0.
     */

    FILE *fp;
    //printf( "reading rec no %d...\n", off );if( off >= getNRecords(filename) ) {
        fprintf( stderr, "ERROR: reading beyond the file.\n" );
        return;
    }
    printf("total records are %d\n",getNRecords(filename));
    fp = fopen( filename, "r" );
    fseek( fp, off*sizeof(node), SEEK_CUR );
    fread( n, sizeof(node), 1, fp );
    fclose(fp);
}

void writeFun( char *filename ) {
    /*
     * writes some data to filename.
     */

    node data[10] = {
                    {5,"five"},
                    {3,"three"},
                    {4,"four"},
                    {8,"eight"},
                    {7,"seven"},
                    {6,"six"},
                    {9,"nine"},
                    {10,"ten"},
                    {1,"one"},
                    {2,"two"}
               };
    int i;
    for( i=0; i<10; ++i )
        writeToFile( filename, data+i );
}

void readFun( char *filename ) {
    /*
     * reads filename and prints the data.
     */

    node n;
    int i, nrec = getNRecords(filename);

    for( i=0; i<nrec; ++i ) {
        readFromFile( filename, &n, i );
        printf( "%2d={%2d,%-5s}.\n", i, n.val, n.s );
    }
}

void copyrec( int *rec, int *rec2 ) {
     int i;
     *rec2 = *rec;

    for( i=0; i<K; ++i )
        rec2[i] = rec[i];
}

void fillbuf( int start, int l, int nrec, char *srcfile ) {
    /*
     * fills buf and rec with appropriate values.
     * l is length of each run.
     * start is rec no of first rec in first run.
     * data is in srcfile in nrec records.
     */
int i;
    printf( "start=%d l=%d.\n", start, l );
    for( i=0; i<K; ++i ) {
        int startoff = start+l*i;
        if( startoff >= nrec )
            break;
        rec[i] = startoff;
        printf( "buf[%d]=%d.\n", i, startoff );
        readFromFile( srcfile, buf+i, startoff );
    }
    for( ; i<K; ++i )
        rec[i] = -1;
    getchar();
}

void updatebuf( node *buf, int *rec, int *rec2, int prevrec, int l, char *srcfile, int nrec ) {
    /*
     * updates buf+rec2 as rec2[prevrec] was output.
     * read appropriate record from srcfile if necessary.
     * rec still contains the original rec nos which can be used for
     *     checking ends of runs.
     * l is runlength.
     */
if( rec2[prevrec] < nrec-1 && rec2[prevrec] < rec[prevrec]+l-1 ) {
        // rec2[prevrec] was NOT the last rec of that run.
        rec2[prevrec]++;
        readFromFile( srcfile, buf+prevrec, rec2[prevrec] );
    }
    else {
        // rec2[prevrec] was the last rec of that run.
        rec2[prevrec] = -1;    // job of this run is over.
    }
}

int getMin( node *buf, int *rec2 ) {
    /*
     * returns index in buf of that record which has min sorting value.
     * rec2 is needed for checking whether a buf entry is valid.
     */
int minval = 9999;
    int minindex = -1;
    int i;

    for( i=0; i<K; ++i )
        if( rec2[i] != -1 && buf[i].val < minval ) {
            minval = buf[i].val;
            minindex = i;
        }
    return minindex;
}

void merge( char *srcfile, char *dstfile, node *buf, int *rec2, int l, int nrec ) {
    /*
     * rec2 contains record numbers being compared; global rec also contains 
     *     the same at this point.
     * buf contains their actual data.
     * l is runlength.
     * srcfile is needed for reading next data.
     * the data is appended to dstfile.
     * total no of records being written is min(l*k,nrec-rec[0]).
     */
int totalrec = l*K;
    int i;
    int nrecremaining = nrec-rec[0];    // no of rec in srcfile yet to be written to dstfile.if( nrecremaining < totalrec )
        totalrec = nrecremaining;
    printf( "totalrec=%d nrecremaining=%d.\n", totalrec, nrecremaining );

    for( i=0; i<totalrec; ++i ) {
        int nextrec = getMin( buf, rec2 );    // here goes the comparison.
        printf( "after getMin: min=%d rec2=%d %d %d  buf=%d %d %d.\n", nextrec, rec2[0], rec2[1], rec2[2], buf[0].val, buf[1].val, buf[2].val );
        if( nextrec == -1 ) {
            fprintf( stderr, "ERROR: merge(): all rec2 are -1!\n" );
            return;
        }
        //printf( "min=%d.\n", nextrec );// this is the index in rec2 of next record to be output.
        writeToFile( dstfile, buf+nextrec );
        // remove this written record. read new record from srcfile if needed.
        updatebuf( buf, rec, rec2, nextrec, l, srcfile, nrec );
        //printf( "after updatebuf : rec2=%d %d %d.\n", rec2[0], rec2[1], rec2[2] );
    }
}

void mergedriver( char *srcfile, char *dstfile ) {
    /*
     * sort+merge srcfile and store in dstfile.
     */
int nrec = getNRecords(srcfile);
    int i, l;
    int rec2[K];
    char tempname[N];

    for( l=1; l<nrec; l*=K ) {
        // l is length of each run.// no of runs = ceil( nrec/l );// we need to consider only K runs at a time.for( i=0; i<nrec; i+=l*K ) {
            // fill buf with appropriate values.
            fillbuf( i, l, nrec, srcfile );
            copyrec( rec, rec2 );
            merge( srcfile, dstfile, buf, rec2, l, nrec );
        }
        unlink( srcfile );
        strcpy( tempname, srcfile );
        strcpy( srcfile, dstfile );
        strcpy( dstfile, tempname );
    }
    // sorted file is srcfile.
    printf( "\n\n\n" );
    readFun( srcfile );
}

int main() {
    char srcfile[N] = DATAFILE;
    char dstfile[N] = TEMPFILE;
    unlink( srcfile );
    unlink( dstfile );
    writeFun( srcfile );
    readFun( srcfile );
    printf( "nrec=%d.\n", getNRecords(srcfile) );
    mergedriver( srcfile, dstfile );

    return 0;
}