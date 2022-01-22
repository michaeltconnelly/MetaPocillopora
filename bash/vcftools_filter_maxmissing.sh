#!/bin/bash
# Step 1: Remove loci with genotype call rate < 95%
/Users/mikeconnelly/opt/miniconda3/bin/vcftools \
--vcf $1 \
--out $2 \
--max-missing $3 \
--recode --recode-INFO-all
