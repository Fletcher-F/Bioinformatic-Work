#!/bin/bash

#Testing Optimal K value for admixture
#Program will loop through admixture 15 times testing k-values of 1-15.
#Files will be exported as log1-log15.out with cv-errors
#Running command line: grep -h CV log* 
#Will print all cv-error files to console to determine optimal K-value (Lowest CV)

#SBATCH --job-name=optimalK
#SBATCH --cpus-per-task=2
#SBATCH --time=06:00:00
#SBATCH --mem=4000M

module load ADMIXTURE

file=/srv/home/falkf@viu.int.viu.ca/OrchidSummerProject/admixture/admixture.bed

for i in {1..15}
do
	admixture --cv pop.admix.bed $i > log${i}.out
done
