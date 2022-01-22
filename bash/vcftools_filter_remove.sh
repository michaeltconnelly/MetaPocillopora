#!/bin/bash
# Step 2: Remove flagged individuals with > 95% missing data
/Users/mikeconnelly/opt/miniconda3/bin/vcftools \
--vcf $1 \
--out $2 \
--remove $3 \
--recode --recode-INFO-all
