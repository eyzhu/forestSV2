for f in data/*.bam
do
    currF=$(echo $f | cut -f2 -d"/" | cut -f1 -d"_")
    echo -e "chr\tfilename\tchrlength\tbas" > $currF"_info.txt"
    echo -e "chr20\t"$f"\thg19\t " >> $currF"_info.txt"
    forestSV --infofile=$currF"_info.txt" --basename=$currF"F" --forest=../rf_1KG_ILMN_BWA_HG19_v1.Rdata
#echo $currF
done
