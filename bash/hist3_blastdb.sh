#!/bin/bash
prodir="/scratch/nmnh_corals/connellym/projects/MetaPocillopora"
/home/connellym/programs/ncbi-magicblast-1.6.0/bin/makeblastdb \
-in ${prodir}/data/Pgrandis_Hist3.fasta \
-out ${prodir}/data/hist3/hist3db \
-parse_seqids -dbtype nucl
