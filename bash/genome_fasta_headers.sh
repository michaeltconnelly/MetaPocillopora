#!/bin/bash
# Modified from: https://bioinformaticsonline.com/snippets/view/33328/unzip-all-the-genome-file-and-remove-all-fasta-header-except-first-one
# Unzip all the genome file and remove all fasta header except first one
#gzip -d *.gz

FILES=$(pwd)/*
for f in $FILES
do
  echo "Processing $f file..."
  	if [[ $f =~ \.fa*$ ]];
	then awk ' /^>/ && FNR > 1 {next} {print $0} ' $f | sed '/^>/{s/ /_/g}' > $f.fa
  	#then sed '1!{/^\>/d;}' $f > $f.fa
  	else echo "this file is not right file"
  	fi
  	#cat $f
done
