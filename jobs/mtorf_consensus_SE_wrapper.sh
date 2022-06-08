#!/bin/bash

prodir="/scratch/nmnh_corals/connellym/projects/MetaPocillopora"
study="$1"
files=$(ls $prodir/data/srareads/$study)
samples=$(echo "$files" | cut -d . -f 1 | sort -u)
#
for sample in $samples
do
echo "# /bin/sh" > $prodir/bash/jobs/mtorf_consensus_${sample}.job
echo "# ----------------Parameters---------------------- #" >> $prodir/bash/jobs/mtorf_consensus_${sample}.job
echo "#$  -S /bin/sh
#$ -pe mthread 4
#$ -q sThC.q
#$ -l mres=64G,h_data=4G,h_vmem=4G" >> $prodir/bash/jobs/mtorf_consensus_${sample}.job
echo "#$ -j y
#$ -N mtorf_consensus_${sample}
#$ -o ${prodir}/bash/jobs/mtorf_consensus_${sample}.log
#$ -m bea
#$ -M connellym@si.edu" >> $prodir/bash/jobs/mtorf_consensus_${sample}.job
#
echo "# ----------------Modules------------------------- #" >> $prodir/bash/jobs/mtorf_consensus_${sample}.job
#
echo "# ----------------Your Commands------------------- #" >> $prodir/bash/jobs/mtorf_consensus_${sample}.job
#
echo 'echo + `date` job $JOB_NAME started in $QUEUE with jobID=$JOB_ID on $HOSTNAME' >> $prodir/bash/jobs/mtorf_consensus_${sample}.job
echo 'echo + NSLOTS = $NSLOTS' >> $prodir/bash/jobs/mtorf_consensus_${sample}.job
#
# Obtain sequences of the ATP6-ORF region for each individual
echo "python ${prodir}/bash/sam2consensus.py \
-i ${prodir}/outputs/mtorf/${study}/${sample}_mtorf.sam \
-c 0.1,0.25,0.5 \
-o ${prodir}/outputs/mtorf/consensus_seqs \
-p ${sample} \
-m 1 \
-d 50" >> $prodir/bash/jobs/mtorf_consensus_${sample}.job

echo 'echo = `date` job $JOB_NAME done' >> $prodir/bash/jobs/mtorf_consensus_${sample}.job
qsub $prodir/bash/jobs/mtorf_consensus_${sample}.job
done
