#!/bin/bash
vcf="$1"
outdir="$2"
outprefix="$3"
mkdir $outdir
# Query SNP stats using vcftools.
# depth indv/locus
/Users/mikeconnelly/opt/miniconda3/bin/vcftools --vcf $vcf --out ${outdir}/${outprefix} --depth
/Users/mikeconnelly/opt/miniconda3/bin/vcftools --vcf $vcf --out ${outdir}/${outprefix} --site-mean-depth
/Users/mikeconnelly/opt/miniconda3/bin/vcftools --vcf $vcf --out ${outdir}/${outprefix} --geno-depth
# missing data indv/locus
/Users/mikeconnelly/opt/miniconda3/bin/vcftools --vcf $vcf --out ${outdir}/${outprefix} --missing-indv
/Users/mikeconnelly/opt/miniconda3/bin/vcftools --vcf $vcf --out ${outdir}/${outprefix} --missing-site
# allele freq/indv freq buden
/Users/mikeconnelly/opt/miniconda3/bin/vcftools --vcf $vcf --out ${outdir}/${outprefix} --indv-freq-burden
/Users/mikeconnelly/opt/miniconda3/bin/vcftools --vcf $vcf --out ${outdir}/${outprefix} --freq2
/Users/mikeconnelly/opt/miniconda3/bin/vcftools --vcf $vcf --out ${outdir}/${outprefix} --singletons
/Users/mikeconnelly/opt/miniconda3/bin/vcftools --vcf $vcf --out ${outdir}/${outprefix} --012
# heterozygosity per individual
/Users/mikeconnelly/opt/miniconda3/bin/vcftools --vcf $vcf --out ${outdir}/${outprefix} --het
# SNP call quality
/Users/mikeconnelly/opt/miniconda3/bin/vcftools --vcf $vcf --out ${outdir}/${outprefix} --site-quality
