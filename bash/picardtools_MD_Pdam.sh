#!/bin/bash
#./bash/picardtools_MD_Pdam.sh
#purpose: sort bam files by coordinate for downstream SNP processing
#To start this job from the EAPSI_Pocillopora_AxH directory, use:
#bsub -P transcriptomics < ./bash/picardtools_MD_Pdam.sh

#BSUB -J picard_MD_pdam
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -o picard_MD_pdam%J.out
#BSUB -e picard_MD_pdam%J.err
#BSUB -n 8
#BSUB -u m.connelly1@umiami.edu

#specify variable containing sequence file prefixes and directory paths
mcs="/scratch/projects/transcriptomics/mikeconnelly"
prodir="/scratch/projects/transcriptomics/mikeconnelly/projects/MetaPocillopora"
#Yuan et al. 2017 (12), Boston University (8),
SRRnums="SRR3727281 SRR3727374 SRR3727379 SRR3727380 SRR3727383 SRR3727387 SRR3727388 SRR3727390 SRR3727400 SRR3727418 SRR3727424 SRR3727425 SRR8568563 SRR8568564 SRR8568567 SRR8568568 SRR8568569 SRR8568565 SRR8568566 SRR8568570"

#lets me know which files are being processed
echo "These are the bam files to be processed : $SRRnums"

module load java/1.8.0_60
module load picard-tools/1.103

for SRRnum in $SRRnums
do \
java -jar /share/apps/picard-tools/1.103/AddOrReplaceReadGroups.jar \
INPUT=${prodir}/outputs/phylotrans_Pdam/${SRRnum}_PdamAligned.sorted.out.bam \
OUTPUT=${prodir}/outputs/phylotrans_Pdam/${SRRnum}_PdamAligned.sorted.out.rg.bam \
RGID=id \
RGLB=library \
RGPL=illumina \
RGPU=unit1 \
RGSM=${SRRnum}

java -jar /share/apps/picard-tools/1.103/MarkDuplicates.jar \
INPUT= ${prodir}/outputs/phylotrans_Pdam/${SRRnum}_PdamAligned.sorted.out.rg.bam \
OUTPUT=${prodir}/outputs/phylotrans_Pdam/${SRRnum}_PdamAligned.sorted.out.md.rg.bam \
CREATE_INDEX=true \
VALIDATION_STRINGENCY=SILENT \
METRICS_FILE=${prodir}/outputs/phylotrans_Pdam/${SRRnum}_marked_dup_metrics.txt
done

bsub -P transcriptomics < ./bash/gatk_splitN_Pdam.sh
echo "Started next job in phylotranscriptomics pipeline: GATK SplitNCigarReads"
