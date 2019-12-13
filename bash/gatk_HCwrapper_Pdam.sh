#!/bin/bash
#./bash/gatk_HCwrapper_Pdam.sh
#purpose: call haplotype variants for EAPSI SNP phylotranscriptomics analysis
#To start this job from the MetaPocillopora directory, use:
#bsub -P transcriptomics < ./bash/gatk_HCwrapper_Pdam.sh

#BSUB -J gatk_HCwrapper_pdam
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

#loop to automate generation of scripts to direct sample variant calling
for SRRnum in $SRRnums
do \
echo "Calling variants in ${SRRnum}"
#   input BSUB commands
echo '#!/bin/bash' > "${prodir}"/bash/jobs/"${SRRnum}"_gatkHC_pdam.job
echo '#BSUB -q bigmem' >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkHC_pdam.job
echo '#BSUB -J '"${SRRnum}"_gatkHC_pdam'' >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkHC_pdam.job
echo '#BSUB -o '"${prodir}"/outputs/logfiles/"$SRRnum"gatkHC_pdam%J.out'' >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkHC_pdam.job
echo '#BSUB -e '"${prodir}"/outputs/errorfiles/"$SRRnum"gatkHC_pdam%J.err'' >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkHC_pdam.job
echo '#BSUB -n 8' >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkHC_pdam.job
echo '#BSUB -W 4:00' >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkHC_pdam.job

#input command to run GATK HaplotypeCaller
#-ERC GVCF \
#-variant_index_type LINEAR -variant_index_parameter 128000 \
#-G Standard
echo java \
-jar /share/apps/GATK/3.4.0/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-I ${prodir}/outputs/phylotrans_Pdam/${SRRnum}_PdamAligned.sorted.out.md.rg.splitN.bam \
-o ${prodir}/outputs/phylotrans_Pdam/${SRRnum}.g.vcf.gz \
-R ${mcs}/sequences/genomes/coral/pocillopora/pdam_genome.fasta \
-stand_call_conf 20.0 \
-dontUseSoftClippedBases >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkHC_pdam.job

#lets me know file is done
echo 'echo' "Variant calling of $SRRnum complete" >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkHC_pdam.job
echo "GATK HaplotypeCaller script of $SRRnum submitted"
#   submit generated trimming script to job queue
bsub < "${prodir}"/bash/jobs/"${SRRnum}"_gatkHC_pdam.job
done

#bsub -P transcriptomics < ./bash/gatk_VF_Pdam.sh
#echo "Started next job in phylotranscriptomics pipeline: GATK VariantFiltration"
