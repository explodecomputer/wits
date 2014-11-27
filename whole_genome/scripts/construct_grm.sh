#!/bin/bash

plink1.90 \
	--bfile ../../randomise_data/geno \
	--make-grm-bin \
	--extract ../data/hapmap3_autosome.snplist \
	--maf 0.01 \
	--out ../data/geno_hm3

plink1.90 \
	--bfile ../../randomise_data/geno \
	--make-grm-bin \
	--extract ../data/metabochip.snplist \
	--maf 0.01 \
	--out ../data/geno_metabochip


