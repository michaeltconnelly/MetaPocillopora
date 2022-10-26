ls | grep -f ../../../data/final_samples_both.txt > final_samples_mtorf_files.txt
cat $(cat final_samples_mtorf_files.txt) > final_samples_mtorf_seqs.fasta
# keep only mtORF consensus sequences with >820 bp for multiple sequence alignment and haplonet construction
# 55 sequences remaining
cat $(cat final_samples_mtorf_files.txt) | grep length:[8-9][2-9][0-9] | awk -F "|" '{print $1}' | awk -F "_" '{print $2}' > final_samples_820bp.txt

#./muscle
# clipkit
# trimAl
