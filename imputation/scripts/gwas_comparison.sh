#!/bin/bash

# Perform using genotypes
plink1.90 \
	--bfile ../../randomise_data/geno \
	--chr 16 \
	--from-bp 50000000 \
	--to-bp 55000000 \
	--pheno ../../randomise_data/phen.txt \
	--mpheno 1 \
	--out ../gwas_example/bmi_geno \
	--assoc

# Perform using imputed SNPs
plink1.90 \
	--bfile ../../randomise_data/geno \
	--chr 16 \
	--from-bp 50000000 \
	--to-bp 55000000 \
	--pheno ../../randomise_data/phen.txt \
	--mpheno 1 \
	--out ../gwas_example/bmi_1kg \
	--assoc
