#Shell Script for Prepping and Running Sequence Data Assembly using Abyss 2.3.10
#Made by Fletcher Falk Feb.17/25
#Script should work in WSL using conda to install all packages
#Requires trimmomatic, fastqc, abyss, and all dependencies
#READ:
#Ensure all sequence data is located inside a folder named: sequence-data
#Ensure this script is given permissions and is located outside of the sequence-data folder
#Ensure sequence data is gziped
#Ensure files are named (filename)(counter)R1.fastq.gz then the paired alternative (filename)(counter)R2.fastq.gz, as I don't really know how to parse it out automatically with awk
#Then just change the filename variable to the filename and ensure counters are in order 1-max
#Initializing PATH Variables
DATA="./sequence-data"
FILENAME="test"

#Initial Quality Checking
mkdir ${DATA}/Initial-Quality
fastqc ${DATA}/*.fastq.gz -o ${DATA}/Initial-Quality

#Trimming
total=$(ls ${DATA}/*.fastq.gz | wc -l)
runs=$(((total / 2) + 1))
counter=1

#Run trimmomatic on each set of paired reads
mkdir ${DATA}/Paired-Filtered-Data
mkdir ${DATA}/Unpaired-Data
while [ $counter -lt $runs ]
do
	trimmomatic PE -phred33 ${DATA}/${FILENAME}${counter}R1.fastq.gz ${DATA}/${FILENAME}${counter}R2.fastq.gz ${DATA}/Paired-Filtered-Data/Filtered${FILENAME}${counter}pairedR1.fastq.gz ${DATA}/Unpaired-Data/Filtered${FILENAME}${counter}unpairedR1.fastq.gz ${DATA}/Paired-Filtered-Data/Filtered${FILENAME}${counter}pairedR2.fastq.gz ${DATA}/Unpaired-Data/Filtered${FILENAME}${counter}unpairedR2.fastq.gz SLIDINGWINDOW:4:20 MINLEN:25 LEADING:20 TRAILING:20
	((counter++))
done
counter=1

#Final Quality Checking
FILTEREDDATA="./sequence-data/Paired-Filtered-Data"
mkdir ${DATA}/Final-Quality
fastqc ${DATA}/Paired-Filtered-Data/*fastq.gz -o ${DATA}/Final-Quality

#Abyss Assembly of Reads
#Change B based on size of genome 2G for ~101Mbp and 50G for ~3.1Gbp
#ADD IN K-mer Optimization chose 58 for now based on github manual

#Final Run
abyss-pe k=58 kc=2 B=2G in="${FILTEREDDATA}/Filtered${FILENAME}1pairedR1.fastq.gz ${FILTEREDDATA}/Filtered${FILENAME}1pairedR2.fastq.gz" name=Bacterial-Assembly 
echo "Done Program"
