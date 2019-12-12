#!/bin/bash
#./bash/phylotrans_start_samtools_Pdam.sh
#purpose: sort bam files by coordinate for downstream SNP processing
#To start this job from the EAPSI_Pocillopora_AxH directory, use:
#bsub -P transcriptomics < ./bash/phylotrans_start_samtools_Pdam.sh

#BSUB -J sort_pdam
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -o sort_pdam%J.out
#BSUB -e sort_pdam%J.err
#BSUB -n 8
#BSUB -u m.connelly1@umiami.edu

#specify variable containing sequence file prefixes and directory paths
mcs="/scratch/projects/transcriptomics/mikeconnelly"
prodir="/scratch/projects/transcriptomics/mikeconnelly/projects/MetaPocillopora"
#Yuan et al. 2017 (12), Boston University (8),
SRRnums="SRR3727281 SRR3727374 SRR3727379 SRR3727380 SRR3727383 SRR3727387 SRR3727388 SRR3727390 SRR3727400 SRR3727418 SRR3727424 SRR3727425 SRR8568563 SRR8568564 SRR8568567 SRR8568568 SRR8568569 SRR8568565 SRR8568566 SRR8568570"

module load java/1.8.0_60
module load samtools/1.3

#lets me know which files are being processed
echo "These are the bam files to be processed : $SRRnums"

#sort output bam files, all outputs now moved to phylotrans_Pdam directory
for SRRnum in $SRRnums
do \
samtools sort \
${prodir}/outputs/STARalign_Pdam/${SRRnum}_PdamAligned.out.bam \
> ${prodir}/outputs/phylotrans_Pdam/${SRRnum}_PdamAligned.sorted.out.bam
done

#index sorted bam files
for SRRnum in $SRRnums
do \
samtools index -b \
${prodir}/outputs/phylotrans_Pdam/${SRRnum}_PdamAligned.sorted.out.bam
done

bsub -P transcriptomics < ./bash/picardtools_MD_Pdam.sh
echo "Started next job in phylotranscriptomics pipeline: picard tools mark duplicates"
