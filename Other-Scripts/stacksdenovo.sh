#!/bin/bash

#De novo stacks run
#Standard denovo_map.pl stacks run 
#Set M and n to optimal values chosen from extractingoptimalM and give correct popmap based on samples (leave m at 3)
#Currently set for paired samples and outputting in vcf format for further filtering

#SBATCH --job-name=<optimal_denovo>
#SBATCH --cpus-per-task=4
#SBATCH --time=48:00:00
#SBATCH --mem=48000M

# --write-single-snp: used when using --structure flag for outputting correctly to STRUCTURE analysis
# -samples = file path to the samples (samples will be read from population map)
# --popmap = file path to the population map (<sample name><TAB><population>)
# -o = file path to write the pipeline output files
# -X = additional options for specific pipeline components, e.g. -X "populations: --min-maf 0.05". We will #run populations separately afterwards
# -M = number of mismatches allowed between stacks within individuals (for ustacks)
# -n =number of mismatches allowed between stacks between individuals (for cstacks)
# -m = Minimum depth of coverage required to create a stack (default 3)
# --paired = after assembling RAD loci, assemble contigs for each locus from paired-end reads
# --rm-pcr-duplicates = remove all but one set of read pairs of the same sample that have the same #insert length
# -r = minimum percentage of individuals in a population required to process a locus for that population #(for populations; default: 0)
# -T = the number of threads/CPUs to use (default: 1)

module load Stacks

denovo_map.pl -M 3 -n 3 -m 3 -o ./stacksoptimal --samples ./RawDataCombination --popmap ./PopulationMap/popmap --paired -X "populations: --vcf"
