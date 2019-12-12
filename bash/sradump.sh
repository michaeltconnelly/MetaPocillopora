#!/bin/bash
#./bash/sradump.sh
#purpose:
#To start this job from the MetaPocillopora directory, use:
#bsub -P transcriptomics < ./bash/sradump.sh

#BSUB -J sradump
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -o sradump%J.out
#BSUB -e sradump%J.err
#BSUB -n 8
#BSUB -u m.connelly1@umiami.edu

#specify variable containing sequence file prefixes and directory paths
mcs="/scratch/projects/transcriptomics/mikeconnelly"
prodir="/scratch/projects/transcriptomics/mikeconnelly/projects/MetaPocillopora"
#Yuan et al. 2017 (12), Boston University (8),
SRRnums="SRR3727281 SRR3727374 SRR3727379 SRR3727380 SRR3727383 SRR3727387 SRR3727388 SRR3727390 SRR3727400 SRR3727418 SRR3727424 SRR3727425 SRR8568563 SRR8568564 SRR8568567 SRR8568568 SRR8568569 SRR8568565 SRR8568566 SRR8568570"

#Make project primary directory
mkdir ${prodir}/bash/jobs
#Make directory for SRA output .fastq files
mkdir ${prodir}/data/srareads

#Run SRA acquisition command by specifying variable containing sequence file prefixes
#Download from NCBI and convert SRA files into .fastq format in output directories
#fastq-dump [options] <accession>
#For loop to automatic .fastq conversion
for SRRnum in $SRRnums
do \
#   input BSUB commands
echo '#!/bin/bash' > "${prodir}"/bash/jobs/"${EAPSIsample}"_sradump.job
echo '#BSUB -q bigmem' >> "${prodir}"/bash/jobs/"${EAPSIsample}"_sradump.job
echo '#BSUB -J '"${EAPSIsample}"_sradump'' >> "${prodir}"/bash/jobs/"${EAPSIsample}"_sradump.job
echo '#BSUB -o '"${prodir}"/outputs/logfiles/"$EAPSIsample"sradump%J.out'' >> "${prodir}"/bash/jobs/"${EAPSIsample}"_sradump.job
echo '#BSUB -e '"${prodir}"/outputs/errorfiles/"$EAPSIsample"sradump%J.err'' >> "${prodir}"/bash/jobs/"${EAPSIsample}"_sradump.job
echo '#BSUB -n 8' >> "${prodir}"/bash/jobs/"${EAPSIsample}"_sradump.job
echo '#BSUB -W 4:00' >> "${prodir}"/bash/jobs/"${EAPSIsample}"_sradump.job

echo "This is the SRA file being downloaded and converted to .fastq format $SRRnum" >> "${prodir}"/bash/jobs/"${EAPSIsample}"_sradump.job
echo ${mcs}/programs/sratoolkit.2.8.2-1-mac64/bin/fastq-dump --split-files \
--outdir ${prodir}/data/srareads/projectname/fastqs \
--gzip \
${SRRnum}
echo 'echo' "$SRRnum acquired and converted to .fastq format"
#   submit generated sra script to job queue
bsub < "${prodir}"/bash/jobs/"${EAPSIsample}"_sradump.job
done
