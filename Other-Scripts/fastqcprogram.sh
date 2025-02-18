#!/bin/bash

#Will run FastQC on all fastq gunzipped files in directory

#SBATCH --job-name=<test1>
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --mem=800M

module load FastQC

fastqc *.fq.gz

