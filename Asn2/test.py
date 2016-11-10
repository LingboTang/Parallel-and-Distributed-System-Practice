def generate_tests():
    test_sizes = [8000000,10000000,20000000,40000000]
    process_pool_sizes = [1,2,4,8]
    repeats = 5
    lineCount = 2 # skip shell header line

    print "#!/bin/sh"

    '''for i in test_sizes:
        for r in range(0,repeats):
            print "./{exe} {n} >> Output/output.txt".format(exe='qsort',n=i)
            lineCount+=1'''



    # psrs runs
    for i in test_sizes:
        for np in process_pool_sizes:
            for r in range(0, repeats):
                print "mpirun -np {np} ./{exe} {n} output.txt >> output{lineCount}.txt"\
                    .format(np=np, exe='mypsrs', n=i, lineCount=lineCount)
                lineCount += 1

if __name__ == "__main__":
    generate_tests()
