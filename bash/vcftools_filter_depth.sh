#!/bin/bash
# Step 3: Remove loci with depth < 20
/Users/mikeconnelly/opt/miniconda3/bin/vcftools \
--vcf $1 \
--out $2 \
--min-meanDP $3 \
--recode --recode-INFO-all
