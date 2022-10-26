#!/bin/bash

prodir="/scratch/nmnh_corals/connellym/projects/MetaPocillopora"
study="$1"
files=$(ls $prodir/data/srareads/$study)
samples=$(echo "$files" | cut -d _ -f 1,2 | sort -u)
#
for sample in $samples
do
echo "# /bin/sh" > $prodir/bash/jobs/hist3_consensus_${sample}.job
echo "# ----------------Parameters---------------------- #" >> $prodir/bash/jobs/hist3_consensus_${sample}.job
echo "#$  -S /bin/sh
#$ -pe mthread 4
#$ -q sThC.q
#$ -l mres=64G,h_data=4G,h_vmem=4G" >> $prodir/bash/jobs/hist3_consensus_${sample}.job
echo "#$ -j y
#$ -N hist3_consensus_${sample}
#$ -o ${prodir}/bash/jobs/hist3_consensus_${sample}.log
#$ -m bea
#$ -M connellym@si.edu" >> $prodir/bash/jobs/hist3_consensus_${sample}.job
#
echo "# ----------------Modules------------------------- #" >> $prodir/bash/jobs/hist3_consensus_${sample}.job
#
echo "# ----------------Your Commands------------------- #" >> $prodir/bash/jobs/hist3_consensus_${sample}.job
#
echo 'echo + `date` job $JOB_NAME started in $QUEUE with jobID=$JOB_ID on $HOSTNAME' >> $prodir/bash/jobs/hist3_consensus_${sample}.job
echo 'echo + NSLOTS = $NSLOTS' >> $prodir/bash/jobs/hist3_consensus_${sample}.job
#
# Obtain sequences of the histone 3 region for each individual
echo "python ${prodir}/bash/sam2consensus.py \
-i ${prodir}/outputs/hist3/${study}/${sample}_hist3.sam \
-c 0.25 \
-o ${prodir}/outputs/hist3/consensus_seqs \
-p ${sample} \
-m 1 \
-d 150" >> $prodir/bash/jobs/hist3_consensus_${sample}.job

echo 'echo = `date` job $JOB_NAME done' >> $prodir/bash/jobs/hist3_consensus_${sample}.job
qsub $prodir/bash/jobs/hist3_consensus_${sample}.job
done
