#!/bin/bash

#Compress

#SBATCH --job-name=<compress>
#SBATCH --cpus-per-task=8
#SBATCH --time=08:00:00
#SBATCH --mem=32000M

gzip *.fastq
