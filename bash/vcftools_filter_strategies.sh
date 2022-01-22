# Query raw stats using vcftools.
# depth indv/locus
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed.vcf --out ./outputs/gbs_results/vcftools_results/all_raw --depth
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed.vcf --out ./outputs/gbs_results/vcftools_results/all_raw --site-mean-depth
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed.vcf --out ./outputs/gbs_results/vcftools_results/all_raw --geno-depth
# missing data indv/locus
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed.vcf --out ./outputs/gbs_results/vcftools_results/all_raw --missing-indv
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed.vcf --out ./outputs/gbs_results/vcftools_results/all_raw --missing-site
# allele freq/indv freq buden
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed.vcf --out ./outputs/gbs_results/vcftools_results/all_raw --indv-freq-burden
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed.vcf --out ./outputs/gbs_results/vcftools_results/all_raw --freq2
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed.vcf --out ./outputs/gbs_results/vcftools_results/all_raw --singletons
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed.vcf --out ./outputs/gbs_results/vcftools_results/all_raw --012
# heterozygosity per individual
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed.vcf --out ./outputs/gbs_results/vcftools_results/all_raw --het
# SNP call quality
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed.vcf --out ./outputs/gbs_results/vcftools_results/all_raw --site-quality


# Query SNP stats using vcftools.
# depth indv/locus
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed_SNPs_only.recode --out ./outputs/gbs_results/etp_pocillopora_all_SNPs --depth
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed_SNPs_only.recode --out ./outputs/gbs_results/etp_pocillopora_all_SNPs --site-mean-depth
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed_SNPs_only.recode --out ./outputs/gbs_results/etp_pocillopora_all_SNPs --geno-depth
# missing data indv/locus
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed_SNPs_only.recode --out ./outputs/gbs_results/etp_pocillopora_all_SNPs --missing-indv
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed_SNPs_only.recode --out ./outputs/gbs_results/etp_pocillopora_all_SNPs --missing-site
# allele freq/indv freq buden
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed_SNPs_only.recode --out ./outputs/gbs_results/etp_pocillopora_all_SNPs --indv-freq-burden
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed_SNPs_only.recode --out ./outputs/gbs_results/etp_pocillopora_all_SNPs --freq2
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed_SNPs_only.recode --out ./outputs/gbs_results/etp_pocillopora_all_SNPs --singletons
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed_SNPs_only.recode --out ./outputs/gbs_results/etp_pocillopora_all_SNPs --012
# heterozygosity per individual
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed_SNPs_only.recode --out ./outputs/gbs_results/etp_pocillopora_all_SNPs --het
# SNP call quality
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed_SNPs_only.recode --out ./outputs/gbs_results/etp_pocillopora_all_SNPs --site-quality

#  Remove loci with genotype call rate < 95%:
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed.vcf --out ./outputs/gbs_results/etp_pocillopora_all_sed_geno95 --max-missing 0.95 --recode --recode-INFO-all
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed.vcf --out ./outputs/gbs_results/etp_pocillopora_all_sed_geno85 --max-missing 0.85 --recode --recode-INFO-all

## Custom filtering strategy for ETP Pocillopora dataset

#2. Output a new vcf file from the input vcf file that removes any indel sites
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_indv_90.vcf --remove-indels --recode --recode-INFO-all --out ./outputs/gbs_results/etp_pocillopora_indv_90_SNPs

#1. Remove individuals with >90% missing data
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_all_sed.vcf --out ./outputs/gbs_results/etp_pocillopora_indv_90 --remove ./outputs/gbs_results/vcftools_results//LQ_indv_90 --recode --recode-INFO-all

#2. Output a new vcf file from the input vcf file that removes any indel sites
vcftools --vcf ./outputs/gbs_results/etp_pocillopora_indv_90.recode.vcf --remove-indels --recode --recode-INFO-all --out ./outputs/gbs_results/etp_pocillopora_indv_90_SNPs

vcf_file="./outputs/gbs_results/etp_pocillopora_indv_90_SNPs.recode.vcf"
output_table="./outputs/gbs_results/vcftools_results/etp_pocillopora_indv_90_SNPs"
# Query SNP stats using vcftools.
# depth indv/locus
vcftools --vcf $vcf_file --out $output_table --depth
vcftools --vcf $vcf_file --out $output_table --site-mean-depth
vcftools --vcf $vcf_file --out $output_table --geno-depth
# missing data indv/locus
vcftools --vcf $vcf_file --out $output_table --missing-indv
vcftools --vcf $vcf_file --out $output_table --missing-site
# allele freq/indv freq buden
vcftools --vcf $vcf_file --out $output_table --indv-freq-burden
vcftools --vcf $vcf_file --out $output_table --freq2
vcftools --vcf $vcf_file --out $output_table --singletons
vcftools --vcf $vcf_file --out $output_table --012
# heterozygosity per individual
vcftools --vcf $vcf_file --out $output_table --het
# SNP call quality
vcftools --vcf $vcf_file --out $output_table --site-quality

#3.  Remove loci with genotype call rate < 75%:
vcftools --vcf $vcf_file --out ./outputs/gbs_results/etp_pocillopora_indv_90_SNPs_geno75 --max-missing 0.75 --recode --recode-INFO-all

vcf_file="./outputs/gbs_results/etp_pocillopora_indv_90_SNPs_geno75.recode.vcf"
output_table="./outputs/gbs_results/vcftools_results/etp_pocillopora_indv_90_SNPs_geno75"
