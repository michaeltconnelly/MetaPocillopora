
#BSUB -J sradump
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -o sradump%J.out
#BSUB -e sradump%J.err
#BSUB -n 8
#BSUB -u m.connelly1@umiami.edu

#purpose:
#To start this job from the MetaPocillopora directory, use:
#qsub -P transcriptomics < ./bash/sradump.sh

#specify variable containing sequence file prefixes and directory paths
prodir="/scratch/nmnh_corals/connellym/projects/MetaPocillopora"
#Yuan et al. 2017 (12), Boston University (8),
#SRRnums="SRR3727281 SRR3727374 SRR3727379 SRR3727380 SRR3727383 SRR3727387 SRR3727388 SRR3727390 SRR3727400 SRR3727418 SRR3727424 SRR3727425 SRR8568563 SRR8568564 SRR8568567 SRR8568568 SRR8568569 SRR8568565 SRR8568566 SRR8568570"
#Wecker et al. 2018
SRRnums=$(cat ${prodir}/data/SraAccList_Wecker_2018.txt)

#Run SRA acquisition command by specifying variable containing sequence file prefixes
#Download from NCBI and convert SRA files into .fastq format in output directories
#fastq-dump [options] <accession>
#For loop to automatic .fastq conversion
for SRRnum in $SRRnums
do \
#   input BSUB commands
echo '#!/bin/bash' > "${prodir}"/bash/jobs/"${SRRnum}"_sradump.job
echo '#BSUB -q bigmem' >> "${prodir}"/bash/jobs/"${SRRnum}"_sradump.job
echo '#BSUB -J '"${SRRnum}"_sradump'' >> "${prodir}"/bash/jobs/"${SRRnum}"_sradump.job
echo '#BSUB -o '"${prodir}"/outputs/logfiles/"$SRRnum"sradump%J.out'' >> "${prodir}"/bash/jobs/"${SRRnum}"_sradump.job
echo '#BSUB -e '"${prodir}"/outputs/errorfiles/"$SRRnum"sradump%J.err'' >> "${prodir}"/bash/jobs/"${SRRnum}"_sradump.job
echo '#BSUB -n 8' >> "${prodir}"/bash/jobs/"${SRRnum}"_sradump.job
echo '#BSUB -W 4:00' >> "${prodir}"/bash/jobs/"${SRRnum}"_sradump.job
#--split-files for paired reads
echo 'echo' "This is the SRA file being downloaded and converted to .fastq format $SRRnum" >> "${prodir}"/bash/jobs/"${SRRnum}"_sradump.job
echo ${mcs}/programs/sratoolkit.2.9.0-ubuntu64/bin/fastq-dump \
--outdir ${prodir}/data/srareads/ \
--gzip \
${SRRnum} >> "${prodir}"/bash/jobs/"${SRRnum}"_sradump.job
echo 'echo' "$SRRnum acquired and converted to .fastq format" >> "${prodir}"/bash/jobs/"${SRRnum}"_sradump.job
#   submit generated sra script to job queue
bsub < "${prodir}"/bash/jobs/"${SRRnum}"_sradump.job
done
