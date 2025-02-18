#!/bin/bash

#extracting values from run
#Will extract r80 stats from denovosubsample run and export them to a set of textfiles

#SBATCH --job-name=optimalM
#SBATCH --cpus-per-task=4
#SBATCH --time=06:00:00
#SBATCH --mem=16000M

module load Stacks
working_dir=/srv/home/falkf@viu.int.viu.ca/OrchidSummerProject/

for i in {1..9}
do
    cat denovorun${i}/populations.r80/populations.haplotypes.tsv | grep -v ^"#" | wc -l >> r80assembledloci.txt
    cat denovorun${i}/populations.r80/populations.hapstats.tsv | grep -v ^"#" | wc -l >> r80polymorphicloci.txt
    cat denovorun${i}/populations.r80/populations.sumstats.tsv | grep -v ^"#" | wc -l >> r80numberSNPs.txt

done
