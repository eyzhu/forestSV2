import glob
import string

interval = 1000

myExperiments = ['01C05676F', '02C10017F', '02C10019F', '02C10230F']

samples = {}

for folder in myExperiments:
    samples[folder] = set()
    calls = glob.glob(folder + '/*.txt')
    #print calls
    with open(calls[0],'r') as callFile:
        callFile.next()
        for line in callFile:
            currLine = line.rstrip()
            currLine = currLine.split()
            #print currLine[1]
            strt = str( int(currLine[1]) - interval )
            nd = str( int(currLine[2]) + interval )
            currLine[1] = strt
            currLine[2] = nd
            #print currLine
            joinedLine = '_'.join(currLine)
            samples[folder].add(joinedLine)
    #print samples[folder]

intersectMat = [''] + myExperiments

for exp1 in myExperiments:
    row = [exp1]
    for exp2 in myExperiments:
        #print samples[exp1]
        print len()
        #row.append(len(samples[exp1] in samples[exp2]))
    intersectMat.append(row)
        
#print intersectMat
# write out to file



