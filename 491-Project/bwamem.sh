#!/bin/bash

#BWA Mapper

#SBATCH --job-name=map-to-ref
#SBATCH --cpus-per-task=8
#SBATCH --time=240:00:00
#SBATCH --mem=0

module load BWA
module load SAMtools

#x=$(ls ./rawdata | wc -l)
#y=$((x / 2))
x=4
y=5
counter=1
mkdir bwamemrun
mkdir ./bwamemrun/marmot${x}bam
mkdir ./bwamemrun/marmot${x}fix
mkdir ./bwamemrun/marmot${x}sort
mkdir ./bwamemrun/marmot${x}markdup
rm -r ./unpairedfiltereddata
rm -r ./rawdata

while [ $counter != $y ]
do
    bwa mem -t 8 ./index_reference/complete_marmot_mito.fasta ./pairedfiltereddata/filtermarmot${counter}pairedR1.fastq.gz ./pairedfiltereddata/filtermarmot${counter}pairedR1.fastq.gz | samtools sort -@ 8 -n -o ./bwamemrun/marmot${x}bam/marmot${counter}.bam
    samtools fixmate -m ./bwamemrun/marmot${x}bam/marmot${counter}.bam ./bwamemrun/marmot${x}fix/marmot${counter}fix.bam
    samtools sort -@ 8 -o ./bwamemrun/marmot${x}sort/marmot${counter}fix-sorted.bam ./bwamemrun/marmot${x}fix/marmot${counter}fix.bam
    samtools markdup -r ./bwamemrun/marmot${x}sort/marmot${counter}fix-sorted.bam ./bwamemrun/marmot${x}markdup/marmot${counter}final.bam
    samtools index ./bwamemrun/marmot${x}markdup/marmot${counter}final.bam

    ((counter++))
done

#view unmapped reads
#should I be removing them?
#samtools view -F 4 -b -o output.bam input.bam

