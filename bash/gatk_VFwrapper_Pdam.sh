#!/bin/bash
#./bash/gatk_VFwrapper_Pdam.sh
#purpose: hard-filter variants for EAPSI SNP phylotranscriptomics analysis
#To start this job from the EAPSI_Pocillopora_AxH directory, use:
#bsub -P transcriptomics < ./bash/gatk_VFwrapper_Pdam.sh

#BSUB -J gatk_VFwrapper_pdam
#BSUB -q general
#BSUB -P transcriptomics
#BSUB -o gatk_VFwrapper_pdam%J.out
#BSUB -e gatk_VFwrapper_pdam%J.err
#BSUB -n 8
#BSUB -u m.connelly1@umiami.edu

#specify variable containing sequence file prefixes and directory paths
mcs="/scratch/projects/transcriptomics/mikeconnelly"
prodir="/scratch/projects/transcriptomics/mikeconnelly/projects/MetaPocillopora"
#Yuan et al. 2017 (12), Boston University (8),
SRRnums="SRR3727281 SRR3727374 SRR3727379 SRR3727380 SRR3727383 SRR3727387 SRR3727388 SRR3727390 SRR3727400 SRR3727418 SRR3727424 SRR3727425 SRR8568563 SRR8568564 SRR8568567 SRR8568568 SRR8568569 SRR8568565 SRR8568566 SRR8568570"

#lets me know which files are being processed
echo "These are the bam files to be processed : $SRRnums"

#loop to automate generation of scripts to direct sample variant filtering
for SRRnum in $SRRnums
do \
echo "Fitlering variants in ${SRRnum}"

#   input BSUB commands
echo '#!/bin/bash' > "${prodir}"/bash/jobs/"${SRRnum}"_gatkVF_pdam.job
echo '#BSUB -q general' >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkVF_pdam.job
echo '#BSUB -J '"${SRRnum}"_gatkVF_pdam'' >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkVF_pdam.job
echo '#BSUB -o '"${prodir}"/outputs/logfiles/"$SRRnum"gatkVF_pdam%J.out'' >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkVF_pdam.job
echo '#BSUB -e '"${prodir}"/outputs/errorfiles/"$SRRnum"gatkVF_pdam%J.err'' >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkVF_pdam.job
echo '#BSUB -n 8' >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkVF_pdam.job
echo '#BSUB -W 4:00' >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkVF_pdam.job
#input command to run GATK VariantFiltration
echo "java \
-jar /share/apps/GATK/3.4.0/GenomeAnalysisTK.jar \
-T VariantFiltration \
-R ${mcs}/sequences/genomes/coral/pocillopora/pdam_genome.fasta \
-V "${prodir}"/outputs/phylotrans_Pdam/"${SRRnum}".g.vcf.gz \
-window 35 \
-cluster 3 \
-filterName FS \
-filter \"FS > 30.0\" \
-filterName QD \
-filter \"QD < 2.0\" \
-o  "${prodir}"/outputs/phylotrans_Pdam/"${SRRnum}".filtered.vcf.gz" >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkVF_pdam.job
#lets me know file is done
echo 'echo' "Variant filtration of $SRRnum complete" >> "${prodir}"/bash/jobs/"${SRRnum}"_gatkVF_pdam.job
echo "GATK VariantFiltration script of $SRRnum submitted"
#   submit generated trimming script to job queue
bsub < "${prodir}"/bash/jobs/"${SRRnum}"_gatkVF_pdam.job
done
