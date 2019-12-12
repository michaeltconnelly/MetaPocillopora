#!/bin/bash
#./bash/meta_pocillopora_setup.sh
#purpose:
#To start this job from the MetaPocillopora directory, use:
#bsub -P transcriptomics < ./bash/meta_pocillopora_setup.sh

#BSUB -J meta_pocillopora_setup
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -o meta_pocillopora_setup%J.out
#BSUB -e meta_pocillopora_setup%J.err
#BSUB -n 8
#BSUB -u m.connelly1@umiami.edu

#specify variable containing sequence file prefixes and directory paths
mcs="/scratch/projects/transcriptomics/mikeconnelly"
prodir="/scratch/projects/transcriptomics/mikeconnelly/projects/MetaPocillopora"
#Yuan et al. 2017 (12), Boston University (8),
SRRnums="SRR3727281 SRR3727374 SRR3727379 SRR3727380 SRR3727383 SRR3727387 SRR3727388 SRR3727390 SRR3727400 SRR3727418 SRR3727424 SRR3727425 SRR8568563 SRR8568564 SRR8568567 SRR8568568 SRR8568569 SRR8568565 SRR8568566 SRR8568570"

mkdir ${prodir}/data
mkdir ${prodir}/data/srareads
mkdir ${prodir}/bash
mkdir ${prodir}/bash/jobs
mkdir ${prodir}/R
mkdir ${prodir}/Rmd
mkdir ${prodir}/outputs
mkdir ${prodir}/outputs/logfiles
mkdir ${prodir}/outputs/errorfiles
mkdir ${prodir}/outputs/fastqcs
mkdir ${prodir}/outputs/trimqcs
mkdir ${prodir}/outputs/trimmomaticreads
mkdir ${prodir}/outputs/STARalign_Pdam
mkdir ${prodir}/outputs/phylotrans_Pdam
echo "Filesystem and project directories created"

#bsub -P transcriptomics < ${prodir}/bash/sradump.sh
