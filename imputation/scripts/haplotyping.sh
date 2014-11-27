#!/bin/bash

# Use ShapeIT version 2 to phase genetype data

./shapeit \
	--input-bed ../data/geno_ftoregion.bed ../data/geno_ftoregion.bim ../data/geno_ftoregion.fam \
	--input-map ../data/genetic_map_chr16_combined_b37.txt.gz \
	--output-max ../data/phased_ftoregion.haps.gz ../data/phased_ftoregion.sample
	--thread 1

# Optional Parameters
## --states <default = 100 but increasing will increase accuracy>
## --window <default = 2 (2mb) which is fine for most SNP chips but the density will be variable in metabochip so inaccuracies may creep in
## --effective-size <effective population size default = 15000, for Africans increase to 17500 but the algorithm is not very sensitive to this change so it doesn't need to be very accurate>
## --burn <n> --prune <n> --main <n> specify the iterations - increasing the number will increase accuracy
