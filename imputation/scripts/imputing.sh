#!/bin/bash

source ../../config

# Use impute2 to impute the output from shapeit2

impute2 \
	-m ../data/genetic_map_chr16_combined_b37.txt.gz \
	-known_haps_g ../data/phased_ftoregion.haps.gz \
	-h ${datadir}/1000GP_Phase3_chr16.hap \
	-l ${datadir}/1000GP_Phase3_chr16.legend \
	-Ne 15000 \
	-k_hap 2000 \
	-int 52000000 53000000 \
	-o ../data/imputed_ftoregion \
	-allow_large_regions \
	-verbose \
	-o_gz \
	-phase


# Convert to best guess

plink1.90 \
	--gen ../data/imputed_ftoregion.gz \
	--sample ../data/phased_ftoregion.sample \
	--oxford-single-chr 16 \
	--make-bed \
	--out ../data/imputed_ftoregion


# Filter on maf > 0.01 and info score > 0.80 and 

plink1.90 \
	--bfile ../data/imputed_ftoregion \
	--qual-scores ../data/imputed_ftoregion_info 6 2 1 \
	--qual-threshold 0.8 \
	--maf 0.01 \
	--make-bed \
	--out ../data/imputed_ftoregion_filtered
