#!/bin/bash
#./bash/fastqc.sh
#purpose: quality checking of raw RNAseq reads using FASTQC on Pegasus compute node
#To start this job from the MetaPocillopora directory, use:
#bsub -P transcriptomics < ./bash/fastqc.sh

#BSUB -J fastqc
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -o fastqc%J.out
#BSUB -e fastqc%J.err
#BSUB -n 8
#BSUB -u mconnelly@rsmas.miami.edu
#BSUB -N

#specify variable containing sequence file prefixes and directory paths
mcs="/scratch/projects/transcriptomics/mikeconnelly"
prodir="/scratch/projects/transcriptomics/mikeconnelly/projects/MetaPocillopora"
#Yuan et al. 2017 (12), Boston University (8),
SRRnums="SRR3727281 SRR3727374 SRR3727379 SRR3727380 SRR3727383 SRR3727387 SRR3727388 SRR3727390 SRR3727400 SRR3727418 SRR3727424 SRR3727425 SRR8568563 SRR8568564 SRR8568567 SRR8568568 SRR8568569 SRR8568565 SRR8568566 SRR8568570"

module load java/1.8.0_60
${mcs}/programs/FastQC/fastqc \
${prodir}/data/srareads/*.fastq.gz \
--outdir ${prodir}/outputs/fastqcs/
