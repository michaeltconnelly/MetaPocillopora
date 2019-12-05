#!/bin/bash
#NOTE: To run bash scripts, change modifications using chmod755 /path/script.sh
#Then call script using bash /path/script.sh

#Make project primary directory
mkdir ~/computing/sequences/srareads/#projectname
#Make directory for SRA output .fastq files
mkdir ~/computing/sequences/srareads/#projectname/fastqs
#General SRA acquisition script
#Change directory to sratoolkit for access to programs for sequence acquisition
cd ~/computing/programs/sratoolkit.2.8.2-1-mac64/bin
#Run SRA acquisition command by specifying variable containing sequence file prefixes
SRRnums="SRR#######"
#Download from NCBI and convert SRA files into .fastq format in output directories
#fastq-dump [options] <accession>
#For loop to automatic .fastq conversion
for SRRnum in $SRRnums
do \
echo "This is the SRA file being downloaded and converted to .fastq format"
echo $SRRnum
./fastq-dump --split-files \
--outdir ~/computing/sequences/srareads/#projectname/fastqs \
${SRRnum} 
echo "$SRRnum acquired and converted to .fastq format"
done

# efetch command for acquiring sequences and generating .csv file with variable names?