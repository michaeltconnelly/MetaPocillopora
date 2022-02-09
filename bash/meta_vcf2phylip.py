
python ./bash/vcf2phylip.py \
-i ./outputs/ipyrad/filtered_vcfs/max-missing-0.05_indv-missing-0.85_depth-20_maf-0.05.recode.vcf \
--output-folder ./outputs/ipyrad/phylips \
--output-prefix max-missing-0.05_indv-missing-0.85_depth-20_maf-0.05

python ./bash/ascbias.py -p \
./outputs/ipyrad/phylips/max-missing-0.05_indv-missing-0.85_depth-20_maf-0.05.min4.phy
