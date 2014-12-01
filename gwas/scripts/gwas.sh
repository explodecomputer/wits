#!/bin/bash

source ../../config

# Perform GWAS on BMI, hypertension, CRP


# BMI

plink1.90 \
	--bfile /global/geneticepi/geno_qc \
	--assoc \
	--pheno ../data/phen.txt \
	--mpheno 1 \
	--out ../results/bmi

plink1.90 \
	--bfile /global/geneticepi/geno_qc \
	--clump ../results/bmi.qassoc \
	--clump-kb 1000 \
	--clump-r2 0.1 \
	--out ../results/bmi

Rscript gwas_graphs.R ../results/bmi.qassoc BMI TRUE


# CRP

plink1.90 \
	--bfile /global/geneticepi/geno_qc \
	--assoc \
	--pheno ../data/phen.txt \
	--mpheno 4 \
	--out ../results/crp

plink1.90 \
	--bfile /global/geneticepi/geno_qc \
	--clump ../results/crp.qassoc \
	--clump-kb 1000 \
	--clump-r2 0.1 \
	--out ../results/crp

Rscript gwas_graphs.R ../results/crp.qassoc CRP TRUE


# Hypertension

plink1.90 \
	--bfile /global/geneticepi/geno_qc \
	--assoc \
	--pheno ../data/phen.txt \
	--mpheno 5 \
	--out ../results/hypertension

plink1.90 \
	--bfile /global/geneticepi/geno_qc \
	--clump ../results/hypertension.assoc \
	--clump-kb 1000 \
	--clump-r2 0.1 \
	--out ../results/hypertension

Rscript gwas_graphs.R ../results/hypertension.assoc Hypertension TRUE
