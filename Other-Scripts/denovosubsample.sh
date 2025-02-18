#!/bin/bash

#De novo stacks run
#Will run denovo_map.pl from stacks 9 times for analyse in determining optimal M and n values
#M and n values will be set from 1-9 in each run.
#Recommened to use subsample of samples otherwise will take upwards of multiple days
#Popmap should be a testmap which just puts all samples into the same population

#SBATCH --job-name=<optimal_m_denovo_acleris>
#SBATCH --cpus-per-task=4
#SBATCH --time=48:00:00
#SBATCH --mem=16000M

module load Stacks
working_dir=/srv/home/falkf@viu.int.viu.ca/

for i in {1..9}
do

mkdir denovorun${i}
denovo_map.pl -M $i -n $i -m 3 -o ./denovorun${i} --samples ./acleris_files --popmap ./PopulationMap/testmap --paired

done
