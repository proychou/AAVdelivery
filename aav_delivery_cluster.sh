#to submit jobs

#!/bin/bash
#See https://teams.fhcrc.org/sites/citwiki/SciComp/Pages/Gizmo%20Cluster%20Quickstart.aspx
#Log in using terminal and FH user id. and pw: ssh proychou@rhino
#To check status of running jobs: squeue -u proychou 
#Pipe to wc -l to get number of jobs in queue
#To cancel jobs: scancel -u proychou
#To view completed jobs: 
#sacct --format=JobID,Start,End,AllocCPUS,MaxRSS,Elapsed,State,Nodelist
#After each batch run, use cat *.out to check for crashes/errors and use rm *.out to clean up the folder

module load bowtie2/2.2.5
module load FastQC/0.11.8-Java-1.8
module load R/3.6.2-foss-2016b-fh1
module load SAMtools/1.8-foss-2016b
module load BBMap/38.44-foss-2016b

#on new nodes (via rhino03)
module load Bowtie2/2.4.1-GCCcore-8.3.0
module load FastQC/0.11.8-Java-1.8
module load R/3.6.2-foss-2019b-fh1
module load SAMtools/1.10-GCCcore-8.3.0
module load BBMap/38.44-foss-2018b

#Prepare reference for bowtie - only need to do this once
# for i in {1..11};do
# bowtie2-build ./refs/rxn2_amp_bc$i.fasta ./refs/rxn2_amp_bc$i
# done



## RNAseq
cd /fh/fast/jerome_k/AAVs_Dan/RNA

## 1. rerun the old one (Dec2019)
for fname in `ls ./fastq_files/first_batch_Dec2019/*.fastq.gz`; do
sbatch -t 2-0 --mem 10G -p campus-new -c 4 ./aav_delivery.sh -s $fname 
done

mkdir -p ./slurm_logs
mv ./slurm-*.out ./slurm_logs/


## DNAseq
cd /fh/fast/jerome_k/AAVs_Dan/DNA

## 1. 200207_M04202_0150_000000000-CVM9L--done 6-may-20
for fname in `ls ./fastq_files/200207_M04202_0150_000000000-CVM9L/*.fastq.gz`; do
sbatch -t 2-0 --mem 10G -p campus-new -c 4 ./aav_delivery.sh -s $fname 
done


## 2. 200505_M04202_0163_000000000-J35DW
for fname in `ls ./fastq_files/200505_M04202_0163_000000000-J35DW/*.fastq.gz`; do
sbatch -t 2-0 --mem 10G -p campus-new -c 4 ./aav_delivery.sh -s $fname 
done




##################################################################
###OLD stuff, ignore
# fname=/fh/fast/jerome_k/AAVs_Dan/fastq_files/A19109-77_S778_L001_R1_001.fastq.gz
#first run: Jan 2020 -- moved these fastqs to a different folder called 'first_batch_Dec2019'
for fname in `ls ./fastq_files/*.fastq.gz`; do
sbatch -t 2-0 -c 4 ./aav_delivery.sh -s $fname 
done


##April 2020: these were on nextseq so first concatenate fastqs
#the April 2020 runs were on the new nodes (via rhino03, hence the campus-new partition)

## 0. rerun the old one
for fname in `ls ./fastq_files/first_batch_Dec2019/*.fastq.gz`; do
sbatch -t 2-0 --mem 10G -p campus-new -c 4 ./aav_delivery.sh -s $fname 
done

## 1. 200409_NS500127_0027_AHJKKYBGXF--monkeys
fqdirname='./fastq_files/200409_NS500127_0027_AHJKKYBGXF--monkeys/'
for samp in E4-A18094-49 E5-A18094-50 E6-A18094-51 E7-A18094-52 E8-A18094-53 E9-A18094-54 E10-A18094-55 E11-A18094-56 E12-A18094-57 F1-A18094-58 F2-A18094-59 F3-A18094-60 F4-A18094-61 F5-A18094-62 F6-A18094-63 F7-A18094-64 F8-A18094-65 F9-A18094-66 F10-A18094-67 F11-A18094-68 F12-A18094-69 G1-A18094-70 G2-A18094-71 G3-A18094-72 G4-A18094-73 G5-A18094-74 G6-A18094-75 G7-A18094-76 G8-A18094-77; do 
echo 'Concatenating '$samp' ...'
cat `ls $fqdirname/$samp*_R1_*.fastq.gz` > $fqdirname'/'$samp'_R1.fastq.gz'
done

rm $fqdirname/*_001.fastq.gz 

for fname in `ls ./fastq_files/200409_NS500127_0027_AHJKKYBGXF--monkeys/*.fastq.gz`; do
sbatch -t 2-0 --mem 10G -p campus-new -c 4 ./aav_delivery.sh -s $fname 
done


## 2. 200414_NS500127_0031_AHJH2YBGXF--monkeys
fqdirname='./fastq_files/200414_NS500127_0031_AHJH2YBGXF--monkeys/'
for samp in E3-A19109-48 E4-A19109-49 E5-A19109-50 E6-A19109-51 E7-A19109-52 E8-A19109-53 E9-A19109-54 E10-A19109-55 E11-A19109-56 E12-A19109-57 F1-A19109-58 F2-A19109-59 F3-A19109-60 F4-A19109-61 F5-A19109-62 F6-A19109-63 F7-A19109-64 F8-A19109-65 F9-A19109-66 F10-A19109-67 F11-A19109-68 F12-A19109-69 G1-A19109-70 G2-A19109-71 G3-A19109-72 G4-A19109-73 G5-A19109-74 G6-A19109-75 G7-A19109-76 G8-A19109-77; do 
echo 'Concatenating '$samp' ...'
cat `ls $fqdirname/$samp*_R1_*.fastq.gz` > $fqdirname'/'$samp'_R1.fastq.gz'
done

rm $fqdirname/*_001.fastq.gz 

for fname in `ls ./fastq_files/200414_NS500127_0031_AHJH2YBGXF--monkeys/*.fastq.gz`; do
sbatch -t 2-0 --mem 10G -p campus-new -c 4 ./aav_delivery.sh -s $fname  
done



## 3. 200420_NS500127_0037_AHJGNLBGXF--monkeys
fqdirname='./fastq_files/200420_NS500127_0037_AHJGNLBGXF--monkeys/'
for samp in B4-A19108-4 B5-A19108-5 B6-A19108-6 B7-A19108-7 B8-A19108-8 B9-A19108-9 B10-A19108-10 B11-A19108-11 B12-A19108-12 C1-A19108-13 C2-A19108-14 C3-A19108-15 C4-A19108-16 C5-A19108-17 C6-A19108-18 C7-A19108-19 C8-A19108-20 C9-A19108-21 C10-A19108-22 C11-A19108-23 C12-A19108-24 D1-A19108-25 D2-A19108-26 D4-A19108-28 D5-A19108-29 D6-A19108-30 D7-A19108-31 D8-A19108-32; do 
echo 'Concatenating '$samp' ...'
cat `ls $fqdirname/$samp*_R1_*.fastq.gz` > $fqdirname'/'$samp'_R1.fastq.gz'
done

rm $fqdirname/*_001.fastq.gz 

for fname in `ls ./fastq_files/200420_NS500127_0037_AHJGNLBGXF--monkeys/*.fastq.gz`; do
sbatch -t 2-0 --mem 10G -p campus-new -c 4 ./aav_delivery.sh -s $fname  
done

## 4. 200423_NS500127_0040_AHJH25BGXF--monkeys
fqdirname='./fastq_files/200423_NS500127_0040_AHJH25BGXF--monkeys/'
for samp in A18093 A18094 A19108 A19109; do 
echo 'Concatenating '$samp' ...'
cat `ls $fqdirname/$samp*_R1_*.fastq.gz` > $fqdirname'/'$samp'_R1.fastq.gz'
done

rm $fqdirname/*_001.fastq.gz 

for fname in `ls ./fastq_files/200423_NS500127_0040_AHJH25BGXF--monkeys/*.fastq.gz`; do
sbatch -t 2-0 --mem 10G -p campus-new -c 4 ./aav_delivery.sh -s $fname 
done

#After all jobs are done, clean up the folder
mkdir -p ./slurm_logs
mv slurm-*.out ./slurm_logs
