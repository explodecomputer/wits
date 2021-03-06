#!/bin/bash

source ../../config

# Extract BMI SNPs

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--extract ../data/bmisnps.txt \
	--recode A \
	--out ../data/bmisnps


# Extract CRP SNPs

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--extract ../data/crpsnps.txt \
	--recode A \
	--out ../data/crpsnps


# Create RData file

R --no-save < extract_instruments.R
