#!/bin/bash
#./bash/trimmomatic.sh
#purpose: wrapper script to submit jobs/ for trimming poor-quality bases and adapter sequences from raw RNAseq reads using Trimmomatic on Pegasus bigmem queue
#To start this job from the MetaPocillopora directory, use:
#bsub -P transcriptomics < ./bash/trimmomatic.sh

#BSUB -J trimmomatic_wrapper
#BSUB -q bigmem
#BSUB -P transcriptomics
#BSUB -o trimwrap%J.out
#BSUB -e trimwrap%J.err
#BSUB -n 8
#BSUB -u mconnelly@rsmas.miami.edu
#BSUB -N

#specify variable containing sequence file prefixes and directory paths
mcs="/scratch/projects/transcriptomics/mikeconnelly"
prodir="/scratch/projects/transcriptomics/mikeconnelly/projects/MetaPocillopora"
#Yuan et al. 2017 (12), Boston University (8),
SRRnums="SRR3727281 SRR3727374 SRR3727379 SRR3727380 SRR3727383 SRR3727387 SRR3727388 SRR3727390 SRR3727400 SRR3727418 SRR3727424 SRR3727425 SRR8568563 SRR8568564 SRR8568567 SRR8568568 SRR8568569 SRR8568565 SRR8568566 SRR8568570"

#lets me know which files are being processed
echo "These are the samples to be processed:"
echo $SRRnums

#loop to automate generation of scripts to direct sequence file trimming
for SRRnum in $SRRnums
do \
echo "$SRRnum"

#   input BSUB commands
echo '#!/bin/bash' > "${prodir}"/bash/jobs/"${SRRnum}"_trimmomatic.job
echo '#BSUB -q general' >> "${prodir}"/bash/jobs/"${SRRnum}"_trimmomatic.job
echo '#BSUB -J '"${SRRnum}"_trimmomatic'' >> "${prodir}"/bash/jobs/"${SRRnum}"_trimmomatic.job
echo '#BSUB -o '"${prodir}"/outputs/logfiles/"$SRRnum"trim%J.out'' >> "${prodir}"/bash/jobs/"${SRRnum}"_trimmomatic.job
echo '#BSUB -e '"${prodir}"/outputs/errorfiles/"$SRRnum"trim%J.err'' >> "${prodir}"/bash/jobs/"${SRRnum}"_trimmomatic.job

#   input command to load modules for trimming
echo 'module load java/1.8.0_60' >> "${prodir}"/bash/jobs/"${SRRnum}"_trimmomatic.job
echo 'module load trimmomatic/0.36' >> "${prodir}"/bash/jobs/"${SRRnum}"_trimmomatic.job

#   input command to unzip raw reads before trimming
echo 'echo 'Unzipping "${SRRnum}"'' >> "${prodir}"/bash/jobs/"${SRRnum}"_trimmomatic.job
echo 'gunzip '"${prodir}"/data/srareads/"${SRRnum}".fastq.gz >> "${prodir}"/bash/jobs/"${SRRnum}"_trimmomatic.job

#   input command to trim raw reads
echo 'echo 'Trimming "${SRRnum}"'' >> "${prodir}"/bash/jobs/"${SRRnum}"_trimmomatic.job
echo '/share/opt/java/jdk1.8.0_60/bin/java -jar /share/apps/trimmomatic/0.36/trimmomatic-0.36.jar \
SE \
-phred33 \
-trimlog '"${prodir}"/outputs/logfiles/"${SRRnum}"_trim.log \
"${prodir}"/data/srareads/"${SRRnum}".fastq \
"${prodir}"/outputs/trimmomaticreads/"${SRRnum}"_trimmed.fastq.gz \
ILLUMINACLIP:"${mcs}"/programs/Trimmomatic-0.36/adapters/TruSeq3-SE.fa:2:30:10 \
LEADING:3 \
TRAILING:3 \
SLIDINGWINDOW:4:15 \
MINLEN:36 >> "${prodir}"/bash/jobs/"${SRRnum}"_trimmomatic.job
echo 'echo '"$SRRnum" trimmed''  >> "${prodir}"/bash/jobs/"${SRRnum}"_trimmomatic.job

#   input command to zip raw reads after trimming
echo 'gzip '"${prodir}"/data/srareads/"${SRRnum}".fastq  >> "${prodir}"/bash/jobs/"${SRRnum}"_trimmomatic.job

#   submit generated trimming script to job queue
bsub < "${prodir}"/bash/jobs/"${SRRnum}"_trimmomatic.job
done
