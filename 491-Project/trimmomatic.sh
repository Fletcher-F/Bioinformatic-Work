#!/bin/bash

#Trimmomatic Trimming on inputs

#SBATCH --job-name=trim
#SBATCH --cpus-per-task=8
#SBATCH --time=240:00:00
#SBATCH --mem=0

#WEIRD POSSIBLE JAVA BUG FIX?
module load Trimmomatic

#x=$(ls ./rawdata | wc -l)
#y=$((x / 2))
y=5
counter=1

while [ $counter != $y ]
do
    java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar PE -threads 8 -phred33 ./rawdata/marmot${counter}R1.fastq.gz ./rawdata/marmot${counter}R2.fastq.gz ./pairedfiltereddata/filtermarmot${counter}pairedR1.fastq.gz ./unpairedfiltereddata/filtermarmot${counter}unpairedR1.fastq.gz ./pairedfiltereddata/filtermarmot${counter}pairedR2.fastq.gz ./unpairedfiltereddata/filtermarmot${counter}unpairedR2.fastq.gz SLIDINGWINDOW:4:20 LEADING:20 TRAILING:20 MINLEN:50
    ((counter++))
done
