#!/bin/bash
#./bash/gatk_HC_Pdam.sh
#purpose: call haplotype variants for EAPSI SNP phylotranscriptomics analysis
#To start this job from the EAPSI_Pocillopora_AxH directory, use:
#bsub -P transcriptomics < ./bash/gatk_HC_Pdam.sh

#BSUB -J gatk_HC_pdam
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -o gatk_HC_pdam%J.out
#BSUB -e gatk_HC_pdam%J.err
#BSUB -n 8
#BSUB -u m.connelly1@umiami.edu

#specify variable containing sequence file prefixes and directory paths
mcs="/scratch/projects/transcriptomics/mikeconnelly"
prodir="/scratch/projects/transcriptomics/mikeconnelly/projects/MetaPocillopora"
#Yuan et al. 2017 (12), Boston University (8),
SRRnums="SRR3727281 SRR3727374 SRR3727379 SRR3727380 SRR3727383 SRR3727387 SRR3727388 SRR3727390 SRR3727400 SRR3727418 SRR3727424 SRR3727425 SRR8568563 SRR8568564 SRR8568567 SRR8568568 SRR8568569 SRR8568565 SRR8568566 SRR8568570"

#lets me know which files are being processed
echo "These are the bam files to be processed : $SRRnums"

#-ERC GVCF \
#-variant_index_type LINEAR -variant_index_parameter 128000 \
#-G Standard
for SRRnum in $SRRnums
do \
java \
-jar /share/apps/GATK/3.4.0/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-I ${prodir}/outputs/phylotrans_Pdam/${SRRnum}_PdamAligned.sorted.out.md.rg.splitN.bam \
-o ${prodir}/outputs/phylotrans_Pdam/${SRRnum}.g.vcf.gz \
-R ${mcs}/sequences/genomes/coral/pocillopora/pdam_genome.fasta \
-stand_call_conf 20.0 \
-dontUseSoftClippedBases
done

bsub -P transcriptomics < ./bash/gatk_VF_Pdam.sh
echo "Started next job in phylotranscriptomics pipeline: GATK VariantFiltration"
