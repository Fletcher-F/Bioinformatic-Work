#!/bin/bash

#Consensus Sequence Calling

#SBATCH --job-name=consensus
#SBATCH --cpus-per-task=8
#SBATCH --time=240:00:00
#SBATCH --mem=0

module load BCFtools
module load SAMtools

#x=$(ls ./rawdata | wc -l)
x=4
#y=$((x / 2))
y=5
counter=1

#First call variants then index, normalize, and filter
#Before generating consensus sequence
#mkdir bcftoolscalls
mkdir consensuscalls
rm -r ./bwamemrun/marmot${x}bam
rm -r ./bwamemrun/marmot${x}fix
rm -r ./bwamemrun/marmot${x}sort


while [ $counter != $y ]
do
    samtools consensus -a --P-het 0 --min-MQ 20 --show-ins yes --show-del yes ./bwamemrun/marmot${x}markdup/marmot${counter}final.bam -o ./consensuscalls/marmot${counter}consensus.fa

    ((counter++))
done

    #bcftools mpileup -Ou -f ./index_reference/complete_marmot_mito.fasta ./bwamemrun/marmot${x}markdup/marmot${counter}final.bam | bcftools call -mv -Oz -o ./bcftoolscalls/marmot${counter}calls.vcf.gz
    #bcftools index ./bcftoolscalls/marmot${counter}calls.vcf.gz
    #bcftools view -i '%QUAL>=20' ./bcftoolscalls/marmot${counter}calls.vcf.gz
    #bcftools norm -f ./index_reference/complete_marmot_mito.fasta ./bcftoolscalls/marmot${counter}calls.vcf.gz -Ob -o ./bcftoolscalls/marmot${counter}calls.norm.bcf
    #bcftools filter --IndelGap 5 ./bcftoolscalls/marmot${counter}calls.norm.bcf -Ob -o ./bcftoolscalls/marmot${counter}calls.norm.flt-indels.bcf
    #bcftools index ./bcftoolscalls/marmot${counter}calls.norm.flt-indels.bcf
    #cat ./index_reference/complete_marmot_mito.fasta | bcftools consensus ./bcftoolscalls/marmot${counter}calls.vcf.gz > ./consensuscalls/marmot${counter}consensus.fa
