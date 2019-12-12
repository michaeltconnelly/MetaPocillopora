#!/bin/bash
#./bash/gatk_splitN_Pdam.sh
#purpose: SplitNCigarReads preprocessing for bam files
#To start this job from the EAPSI_Pocillopora_AxH directory, use:
#bsub -P transcriptomics < ./bash/gatk_splitN_Pdam.sh

#BSUB -J gatk_splitN_pdam
#BSUB -q bigmem
#BSUB -P transcriptomics
#BSUB -o gatk_splitN_pdam%J.out
#BSUB -e gatk_splitN_pdam%J.err
#BSUB -n 8
#BSUB -u m.connelly1@umiami.edu

#specify variable containing sequence file prefixes and directory paths
mcs="/scratch/projects/transcriptomics/mikeconnelly"
prodir="/scratch/projects/transcriptomics/mikeconnelly/projects/MetaPocillopora"
#Yuan et al. 2017 (12), Boston University (8),
SRRnums="SRR3727281 SRR3727374 SRR3727379 SRR3727380 SRR3727383 SRR3727387 SRR3727388 SRR3727390 SRR3727400 SRR3727418 SRR3727424 SRR3727425 SRR8568563 SRR8568564 SRR8568567 SRR8568568 SRR8568569 SRR8568565 SRR8568566 SRR8568570"

module load samtools/1.3
module load java/1.8.0_60
export _JAVA_OPTIONS="-Xmx2g"
module load GATK/3.4.0

#lets me know which files are being processed
echo "These are the bam files to be processed : $SRRnums"
#--filter_reads_with_N_cigar
for SRRnum in $SRRnums
do \
java \
-jar /share/apps/GATK/3.4.0/GenomeAnalysisTK.jar \
-T SplitNCigarReads \
-I ${prodir}/outputs/phylotrans_Pdam/${SRRnum}_PdamAligned.sorted.out.md.rg.bam \
-o ${prodir}/outputs/phylotrans_Pdam/${SRRnum}_PdamAligned.sorted.out.md.rg.splitN.bam \
-R ${mcs}/sequences/genomes/coral/pocillopora/pdam_genome.fasta \
-rf ReassignOneMappingQuality \
-RMQF 255 -RMQT 60 \
-U ALLOW_N_CIGAR_READS
done

bsub -P transcriptomics < ./bash/gatk_BSQR_Pdam.sh
echo "Started next job in phylotranscriptomics pipeline: GATK BaseRecalibrator"
