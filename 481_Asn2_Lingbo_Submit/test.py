def generate_tests():
    test_sizes = [8000000,16000000,32000000,64000000]
    process_pool_sizes = [2,4,8]
    repeats = 7
    lineCount = 1 # skip shell header line

    print "#!/bin/sh"

    '''for i in test_sizes:
        for r in range(0,repeats):
            print "./{exe} {n} >> Output/output.txt".format(exe='qsort',n=i)
            lineCount+=1'''



    # psrs runs
    for i in test_sizes:
        for np in process_pool_sizes:
            for r in range(0, repeats):
                print "mpirun -np {np} ./{exe} {n} multiple/output{lineCount}.txt"\
                    .format(np=np, exe='mypsrs', n=i, lineCount=lineCount)
                lineCount += 1

    for i in test_sizes:
        for np in process_pool_sizes:
            for r in range(0, repeats):
                print "mpirun -np {np} ./{exe} {n} mutiple/suboutput{lineCount}.txt"\
                    .format(np=np, exe='total', n=i, lineCount=lineCount)
                lineCount += 1


if __name__ == "__main__":
    generate_tests()
