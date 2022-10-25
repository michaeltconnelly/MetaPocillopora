#!/bin/bash
# for assembling consensus mtORF sequences and reference sequences in a single working directory
dir=$(pwd) # current working directory to contain selected fasta sequences and alignments
sample_list=$1 # file with specified sample IDs in working directory
prefix=$(ls $sample_list | cut -d . -f 1)
cons_dir=$2 # path to directory containing all consensus sequences
ref_file=$3 # path to reference mtORF file to add to consensus sequences

touch $dir/${prefix}_files.txt

ls $cons_dir | grep -f $sample_list > $dir/${prefix}_files.txt

# keep only mtORF consensus sequences with >900 bp for multiple sequence alignment and haplonet construction
# 55 sequences remaining
cat $(cat $dir/${prefix}_files.txt) | grep length:[9][0-9][0-9] | awk -F "|" '{print $1}' | awk -F "_" '{print $2}' > $dir/${prefix}_900bp.txt

ls $cons_dir | grep -f $dir/${prefix}_900bp.txt > $dir/${prefix}_900bp_files.txt

# print how many files remaining
echo $(wc -l $dir/${prefix}_900bp_files.txt)

# assemble all sequences of acceptable length into a single fasta file
cat $(cat $dir/${prefix}_900bp_files.txt) > $dir/${prefix}_seqs.fasta

# print sequence headers remaining
#echo $(cat $dir/${prefix}_seqs.fasta | grep ">")

# add reference sequences
touch $dir/${prefix}_refs_seqs.fasta
cat $ref_file >> $dir/${prefix}_refs_seqs.fasta
cat $dir/${prefix}_seqs.fasta >> $dir/${prefix}_refs_seqs.fasta

# perform multiple sequence alignment w/ muscle
muscle -in $dir/${prefix}_refs_seqs.fasta -out $dir/${prefix}_refs_aligned.fasta

# trim msa with clipkit


# trim msa with trimAl

# example command and outputsbash ../../../bash/mtorf_alignment_process.sh elite_samples.txt /Users/mikeconnelly/computing/projects/pocillopora_meta/outputs/mtorf/consensus_seqs /Users/mikeconnelly/computing/projects/pocillopora_meta/data/mtorf_seqs/mtorf_refs.fasta
# 38 /Users/mikeconnelly/computing/projects/pocillopora_meta/outputs/mtorf/msa/elite_samples_900bp_files.txt
#
# MUSCLE v3.8.1551 by Robert C. Edgar
#
#http://www.drive5.com/muscle
#This software is donated to the public domain.
#Please cite: Edgar, R.C. Nucleic Acids Res 32(5), 1792-97.

#elite_samples_refs_seqs 47 seqs, lengths min 842, max 946, avg 920
#00:00:00      1 MB(0%)  Iter   1  100.00%  K-mer dist pass 1
#00:00:00      1 MB(0%)  Iter   1  100.00%  K-mer dist pass 2
#00:00:01     29 MB(0%)  Iter   1  100.00%  Align node
#00:00:01     29 MB(0%)  Iter   1  100.00%  Root alignment
#00:00:02     30 MB(0%)  Iter   2  100.00%  Refine tree
#00:00:02     30 MB(0%)  Iter   2  100.00%  Root alignment
#00:00:02     30 MB(0%)  Iter   2  100.00%  Root alignment
#00:00:03     30 MB(0%)  Iter   3  100.00%  Refine biparts
