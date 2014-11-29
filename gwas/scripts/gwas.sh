#!/bin/bash


# Perform GWAS on BMI, hypertension, CRP


# BMI

plink1.90 \
	--bfile ../../randomise_data/geno \
	--assoc \
	--pheno ../../randomise_data/geno/phen.txt \
	--mpheno 1 \
	--out ../results/bmi

plink1.90 \
	--bfile ../../randomise_data/geno \
	--clump ../results/bmi.qassoc \
	--clump-kb 1000 \
	--clump-r2 0.1 \
	--out ../results/bmi

Rscript gwas_graphs.R bmi.qassoc BMI


# CRP

plink1.90 \
	--bfile ../../randomise_data/geno \
	--assoc \
	--pheno ../../randomise_data/geno/phen.txt \
	--mpheno 4 \
	--out ../results/crp

plink1.90 \
	--bfile ../../randomise_data/geno \
	--clump ../results/crp.qassoc \
	--clump-kb 1000 \
	--clump-r2 0.1 \
	--out ../results/crp

Rscript gwas_graphs.R crp.qassoc CRP


# Hypertension

plink1.90 \
	--bfile ../../randomise_data/geno \
	--assoc \
	--pheno ../../randomise_data/geno/phen.txt \
	--mpheno 5 \
	--out ../results/hypertension

plink1.90 \
	--bfile ../../randomise_data/geno \
	--clump ../results/hypertension.assoc \
	--clump-kb 1000 \
	--clump-r2 0.1 \
	--out ../results/hypertension

Rscript gwas_graphs.R hypertension.assoc Hypertension
