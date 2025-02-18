#!/bin/bash

#Decompress

#SBATCH --job-name=<decompress>
#SBATCH --cpus-per-task=8
#SBATCH --time=08:00:00
#SBATCH --mem=32000M

gunzip *.fastq.gz