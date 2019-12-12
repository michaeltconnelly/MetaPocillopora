#!/bin/bash
#./bash/gatk_BSQR_Pdam.sh
#purpose: Base Quality Recalibration preprocessing for bam files
#To start this job from the EAPSI_Pocillopora_AxH directory, use:
#bsub -P transcriptomics < ./bash/gatk_BSQR_Pdam.sh

#BSUB -J gatk_BSQR_pdam
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -o gatk_BSQR_pdam%J.out
#BSUB -e gatk_BSQR_pdam%J.err
#BSUB -n 8
#BSUB -u m.connelly1@umiami.edu

#specify variable containing sequence file prefixes and directory paths
mcs="/scratch/projects/transcriptomics/mikeconnelly"
prodir="/scratch/projects/transcriptomics/mikeconnelly/projects/MetaPocillopora"
#Yuan et al. 2017 (12), Boston University (8),
SRRnums="SRR3727281 SRR3727374 SRR3727379 SRR3727380 SRR3727383 SRR3727387 SRR3727388 SRR3727390 SRR3727400 SRR3727418 SRR3727424 SRR3727425 SRR8568563 SRR8568564 SRR8568567 SRR8568568 SRR8568569 SRR8568565 SRR8568566 SRR8568570"

#lets me know which files are being processed
echo "These are the bam files to be processed : $SRRnums"
#--filter_reads_with_N_cigar
for SRRnum in $SRRnums
do \
java \
-jar /share/apps/GATK/3.4.0/GenomeAnalysisTK.jar \
-T BaseRecalibrator \
-R ${mcs}/sequences/genomes/coral/pocillopora/pdam_genome.fasta \
-I ${prodir}/outputs/phylotrans_Pdam/${SRRnum}_PdamAligned.sorted.out.md.rg.splitN.bam \
--known-sites sites_of_variation.vcf \
-o ${prodir}/outputs/phylotrans_Pdam/${SRRnum}_Pdam_recal_data.table.grp
done

for SRRnum in $SRRnums
do \
java \
-jar /share/apps/GATK/3.4.0/GenomeAnalysisTK.jar \
-T ApplyBQSR \
-R ${mcs}/sequences/genomes/coral/pocillopora/pdam_genome.fasta \
-I ${prodir}/outputs/phylotrans_Pdam/${SRRnum}_PdamAligned.sorted.out.md.rg.splitN.bam \
--bqsr-recal-file ${prodir}/outputs/phylotrans_Pdam/${SRRnum}_Pdam_recal_data.table.grp \
-O ${prodir}/outputs/phylotrans_Pdam/${SRRnum}_PdamAligned.sorted.out.md.rg.splitN.BSQR.bam
done

for SRRnum in $SRRnums
do \
java -jar /share/apps/GATK/3.4.0/GenomeAnalysisTK.jar \
-T PrintReads \
-R ${mcs}/sequences/genomes/coral/pocillopora/pdam_genome.fasta \
-I ${prodir}/outputs/phylotrans_Pdam/${SRRnum}_PdamAligned.sorted.out.md.rg.splitN.bam \
-BQSR ${prodir}/outputs/phylotrans_Pdam/${SRRnum}_Pdam_recal_data.table.grp \
-o ${prodir}/outputs/phylotrans_Pdam/${SRRnum}_PdamAligned.sorted.out.md.rg.splitN.BSQR.bam
 done

 bsub -P transcriptomics < ./bash/gatk_HC_Pdam.sh
 echo "Started next job in phylotranscriptomics pipeline: GATK HaplotypeCaller"
