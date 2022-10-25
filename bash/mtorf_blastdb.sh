#!/bin/bash
prodir="/scratch/nmnh_corals/connellym/projects/MetaPocillopora"
/home/connellym/programs/ncbi-magicblast-1.6.0/bin/makeblastdb \
-in ${prodir}/data/atp6900seqconsensus.fasta \
-out ${prodir}/data/mtorf/mtORFdb \
-parse_seqids -dbtype nucl
