for mFile in $(find . -name *calls.txt); do
    #echo cut -d"/" -f2 mFile
    pathName=${mFile%/*} #$(cut -d"/" -f2 $mFile)
    if [[ $pathName == *noF* ]] || [[ $pathName == *filter* ]]; then
	continue
    fi
    #echo ${mFile%/*}
    #echo ${mFile%/*}'/DUP.txt'
    awk '($6=="DUP") && ($5>.3)' $mFile | cut -f1-3 > ${mFile%/*}'/calls.bed' 
    awk '($6=="DEL") && ($5>.5)' $mFile | cut -f1-3 >> ${mFile%/*}'/calls.bed'
done    
    #awk '($6=="DUP") && ($5>.5)' mFile > 
    #awk '($6=="DEL") && ($5>.5)' mFile >
