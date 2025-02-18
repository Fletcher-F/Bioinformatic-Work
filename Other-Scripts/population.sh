#!/bin/bash

#Exclusively de novo stacks (population) run
#Currently set to optimal populations filtering values:
#-r 0.8 for r80 data --min-maf 0.5 and --max-obs-het 0.7
#Also exporting for vcf format and enabling --fstats for Fst values

#SBATCH --job-name=pop_orchid
#SBATCH --cpus-per-task=4
#SBATCH --time=48:00:00
#SBATCH --mem=32000M

module load Stacks

populations --popmap ./PopulationMap/popmap -V ./FilteredResults/optimal_filtered.vcf -O ./FilteredResults/OptimalPopulationsFiltered --fstats -r 0.8 --min-maf 0.5 --max-obs-het 0.7 --vcf
