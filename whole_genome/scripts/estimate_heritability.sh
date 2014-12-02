#!/bin/bash

source ../../config


# BMI
gcta64 \
	--grm ../data/geno_hm3 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/bmi_hm3 \
	--thread-num 8

gcta64 \
	--grm ../data/geno_metabochip \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/bmi_metabochip \
	--thread-num 8

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/bmi_hm3_metabochip \
	--thread-num 8


# CRP
gcta64 \
	--grm ../data/geno_hm3 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/crp_hm3 \
	--thread-num 8

gcta64 \
	--grm ../data/geno_metabochip \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/crp_metabochip \
	--thread-num 8

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/bmi_hm3_metabochip \
	--thread-num 8


# Hypertension
gcta64 \
	--grm ../data/geno_hm3 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/hyp_hm3 \
	--thread-num 8

gcta64 \
	--grm ../data/geno_metabochip \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/crp_metabochip \
	--thread-num 8

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/bmi_hm3_metabochip \
	--thread-num 8


# Bivariate analysis
gcta64 \
	--grm ../data/geno_hm3 \
	--reml-bivar 1 2
	--pheno ../../gwas/data/phen.txt \
	--mpheno 5 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/bmi-crp_hm3_metabochip \
	--thread-num 8
