import glob
import string
import subprocess

#interval = 1000

myExperiments = ['01C05676F', '02C10017F', '02C10019F', '02C10230F']

samples = {}

for folder in myExperiments:
    #samples[folder] = set()
    currFile = glob.glob(folder + '/*.bed')
    samples[folder] = currFile[0] 
    #print calls
   
intersectMat = [[''] + myExperiments]

for exp1 in myExperiments:
    myrow = [exp1]
    for exp2 in myExperiments:
#        print samples[exp1]
 #       print samples[exp2]
        cmd = "intersectBed -a " + samples[exp1] + " -b " + samples[exp2] #+ #" | awk \'{sum+=$3-$2} END {print sum}\'"        
        cmd = cmd.split(' ')
        process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
        output = process.communicate()[0].split('\n')
        #print output
        baseSum = 0
        for line in output:
            myLine = line.split('\t')
            if len(myLine) == 1:
                continue
            baseSum += int(myLine[2]) - int(myLine[1])
        myrow.append(str(baseSum))
    intersectMat.append(myrow)        

print intersectMat
# write out to file
with open("overlap.txt",'w+') as outF:
    for line in intersectMat:
        outF.write(','.join(line) + '\n')
