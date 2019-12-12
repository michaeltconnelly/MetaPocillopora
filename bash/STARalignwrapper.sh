#!/bin/bash
#./bash/STARalignwrapper_Pdam_v2.sh
#purpose: align trimmed RNAseq reads against the Pocillopora damicornis genome using STAR on the Pegasus bigmem queue
#version 2: two-pass alignment for improved splice junction detection accuracy, downstream SNP calling and phylotranscriptomics, output non-aligning reads for Symbiodinaceae analysis
#To start this job from the EAPSI_Pocillopora_AxH directory, use:
#bsub -P transcriptomics < /scratch/projects/transcriptomics/mikeconnelly/projects/EAPSI_Pocillopora_AxH/bash/STARalignwrapper_Pdam_v2.sh

#BSUB -J starwrap_pdam
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -o STARwrap_pdam%J.out
#BSUB -e STARwrap_pdam%J.err
#BSUB -n 8
#BSUB -u m.connelly1@umiami.edu

#specify variable containing sequence file prefixes and directory paths
mcs="/scratch/projects/transcriptomics/mikeconnelly"
prodir="/scratch/projects/transcriptomics/mikeconnelly/projects/MetaPocillopora"
#Yuan et al. 2017 (12), Boston University (8),
SRRnums="SRR3727281 SRR3727374 SRR3727379 SRR3727380 SRR3727383 SRR3727387 SRR3727388 SRR3727390 SRR3727400 SRR3727418 SRR3727424 SRR3727425 SRR8568563 SRR8568564 SRR8568567 SRR8568568 SRR8568569 SRR8568565 SRR8568566 SRR8568570"

#lets me know which files are being processed
echo "These are the reads to be aligned to the Pocillopora reference genome: $SRRnums"

#loop to automate generation of scripts to direct sequence file trimming
for SRRnum in $SRRnums
do \
echo "Aligning ${SRRnum}"

#   input BSUB commands
echo '#!/bin/bash' > "${prodir}"/bash/jobs/"${SRRnum}"_staralign_pdam.job
echo '#BSUB -q bigmem' >> "${prodir}"/bash/jobs/"${SRRnum}"_staralign_pdam.job
echo '#BSUB -J '"${SRRnum}"_staralign_pdam'' >> "${prodir}"/bash/jobs/"${SRRnum}"_staralign_pdam.job
echo '#BSUB -o '"${prodir}"/outputs/logfiles/"$SRRnum"staralign_pdam%J.out'' >> "${prodir}"/bash/jobs/"${SRRnum}"_staralign_pdam.job
echo '#BSUB -e '"${prodir}"/outputs/errorfiles/"$SRRnum"staralign_pdam%J.err'' >> "${prodir}"/bash/jobs/"${SRRnum}"_staralign_pdam.job
echo '#BSUB -n 8' >> "${prodir}"/bash/jobs/"${SRRnum}"_staralign_pdam.job
echo '#BSUB -W 4:00' >> "${prodir}"/bash/jobs/"${SRRnum}"_staralign_pdam.job

#   input command to run STAR aligner
echo ${mcs}/programs/STAR-2.5.3a/bin/Linux_x86_64/STAR \
--runMode alignReads \
--quantMode TranscriptomeSAM \
--runThreadN 16 \
--readFilesIn ${prodir}/outputs/trimmomaticreads/${SRRnum}_trimmed.fastq.gz \
--readFilesCommand gunzip -c \
--genomeDir ${mcs}/sequences/genomes/coral/pocillopora/STARindex \
--sjdbGTFfeatureExon exon \
--sjdbGTFtagExonParentTranscript Parent \
--sjdbGTFfile  ${mcs}/sequences/genomes/coral/pocillopora/pdam_genome.gff \
--twopassMode Basic \
--twopass1readsN -1 \
--outStd Log BAM_Unsorted BAM_Quant \
--outSAMtype BAM Unsorted \
--outReadsUnmapped Fastx \
--outFileNamePrefix ${prodir}/outputs/STARalign_Pdam/${SRRnum}_Pdam >> "${prodir}"/bash/jobs/"${SRRnum}"_staralign_pdam.job

#lets me know file is done
echo 'echo' "STAR alignment of $SRRnum complete"'' >> "${prodir}"/bash/jobs/"${SRRnum}"_staralign_pdam.job
echo "STAR alignment script of $SRRnum submitted"
#   submit generated trimming script to job queue
bsub < "${prodir}"/bash/jobs/"${SRRnum}"_staralign_pdam.job
done
