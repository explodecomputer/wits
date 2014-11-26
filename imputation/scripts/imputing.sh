#!/bin/bash

# Use impute2 to impute the output from shapeit2

./impute2 \
	-m ../data/genetic_map_chr16_combined_b37.txt \
	-known_haps_g ../data/phased_ftoregion.haps.gz \
	-h ../data/1000GP_Phase3_chr16.hap.gz \
	-l ../data/1000GP_Phase3_chr16.legend.gz \
	-Ne 15000 \
	-k_hap 2000 \
	-int 50000000 55000000 \
	-o ../data/imputed_ftoregion \
	-allow_large_regions \
	-verbose \
	-o_gz \
	-phase
