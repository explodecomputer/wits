#!/bin/bash

source ../../config

# Perform using genotypes
plink1.90 \
	--bfile ${datadir}/randomise_data/geno_qc \
	--chr 16 \
	--from-bp 50000000 \
	--to-bp 55000000 \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--out ../gwas_example/bmi_geno \
	--assoc

# Perform using imputed SNPs
plink1.90 \
	--bfile ${datadir}/randomise_data/geno_qc \
	--chr 16 \
	--from-bp 50000000 \
	--to-bp 55000000 \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--out ../gwas_example/bmi_1kg \
	--assoc
