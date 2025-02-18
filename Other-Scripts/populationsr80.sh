#!/bin/bash

#Rerunning populations with r80
#For use when determing optimal M and n values

#SBATCH --job-name=populationsr80
#SBATCH --cpus-per-task=8
#SBATCH --time=06:00:00
#SBATCH --mem=16000M

module load Stacks
working_dir=/srv/home/falkf@viu.int.viu.ca/OrchidSummerProject/

for i in {1..9}
do
    populations --popmap ./PopulationMap/testmap -P ./denovorun${i} -O ./denovorun${i}/populations.r80 -r 0.80 

done
