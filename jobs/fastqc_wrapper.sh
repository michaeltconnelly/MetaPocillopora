#!/bin/bash

prodir="/scratch/nmnh_corals/connellym/projects/MetaPocillopora"
study="$1"

echo "# /bin/sh
# ----------------Parameters---------------------- #
#$  -S /bin/sh
#$ -pe mthread 16
#$ -q sThC.q
#$ -l mres=16G,h_data=1G,h_vmem=1G
#$ -cwd
#$ -j y
#$ -N fastqc_${study}
#$ -o fastqc_${study}.log
#$ -m bea
#$ -M connellym@si.edu" > $prodir/bash/jobs/fastqc_${study}.job
#
echo "#" >> $prodir/bash/jobs/fastqc_${study}.job
echo "# ----------------Modules------------------------- #" >> $prodir/bash/jobs/fastqc_${study}.job
echo "module load bioinformatics/fastqc" >> $prodir/bash/jobs/fastqc_${study}.job
echo "#
# ----------------Your Commands------------------- #
#" >> $prodir/bash/jobs/fastqc_${study}.job
echo "echo + `date` job $JOB_NAME started in $QUEUE with jobID=$JOB_ID on $HOSTNAME" >> $prodir/bash/jobs/fastqc_${study}.job
echo "echo + NSLOTS = $NSLOTS" >> $prodir/bash/jobs/fastqc_${study}.job
echo "#" >> $prodir/bash/jobs/fastqc_${study}.job
#
echo "fastqc \
${prodir}/data/srareads/Brener-Raffali2018/* \
--threads $NSLOTS \
-o ${prodir}/outputs/QCs/fastqcs/" >> $prodir/bash/jobs/fastqc_${study}.job
#
echo "echo = `date` job $JOB_NAME done" >> $prodir/bash/jobs/fastqc_${study}.job

qsub $prodir/bash/jobs/fastqc_${study}.job
