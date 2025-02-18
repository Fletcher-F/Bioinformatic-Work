#!/bin/bash

#Converting vcf to admixture ready format with plink
#Requires adding a "c" or some character to chromosome numbers in .vcf file:
#Use: sed '/^[[:digit:]]/s/^/c/' input.vcf > newfile.vcf
#Otherwise get error saying chromosome values are higher than 21 (as we did denovo)

#SBATCH --job-name=vcftoadmixture
#SBATCH --cpus-per-task=4
#SBATCH --time=48:00:00
#SBATCH --mem=16000M

module load PLINK

plink2 --vcf ./FilteredResults/OptimalPopulationsFiltered/optimal_filtered_population_c.vcf --make-bed --out ./admixture_populationfilteredoptimal/pop.admix --allow-extra-chr 0
