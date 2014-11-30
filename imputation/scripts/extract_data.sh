#!/bin/bash

source ../../config


# Extract some SNPs and some individuals
# 500 individuals, 5 MB region around FTO using SNP chip
plink1.90 \
	--bfile ${datadir}/geno_qc \
	--keep ../data/keepids.txt \
	--make-bed \
	--from-bp 49000000 \
	--to-bp 56000000 \
	--out ../data/geno_ftoregion