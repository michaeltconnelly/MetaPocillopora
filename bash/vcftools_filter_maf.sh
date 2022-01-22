#!/bin/bash
# Step 4: Remove loci with minor allele frequency < 5%
/Users/mikeconnelly/opt/miniconda3/bin/vcftools \
--vcf $1 \
--out $2 \
--maf $3 \
--recode --recode-INFO-all
