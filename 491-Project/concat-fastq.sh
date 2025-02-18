#!/bin/bash

#Concatonate Fastq files

#SBATCH --job-name=<concat>
#SBATCH --cpus-per-task=8
#SBATCH --time=08:00:00
#SBATCH --mem=32000M

cat *.fq.gz >> concatenated.fq.gz