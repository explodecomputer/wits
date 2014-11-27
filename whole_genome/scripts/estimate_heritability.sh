#!/bin/bash


# BMI
gcta64 \
	--grm ../data/geno_hm3 \
	--reml \
	--reml-no-lrt \
	--pheno ../../randomise_data/phen.txt \
	--mpheno 1 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/bmi_hm3 \
	--thread-num 4

gcta64 \
	--grm ../data/geno_metabochip \
	--reml \
	--reml-no-lrt \
	--pheno ../../randomise_data/phen.txt \
	--mpheno 1 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/bmi_metabochip \
	--thread-num 4

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../randomise_data/phen.txt \
	--mpheno 1 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/bmi_hm3_metabochip \
	--thread-num 4


# CRP
gcta64 \
	--grm ../data/geno_hm3 \
	--reml \
	--reml-no-lrt \
	--pheno ../../randomise_data/phen.txt \
	--mpheno 4 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/crp_hm3 \
	--thread-num 4

gcta64 \
	--grm ../data/geno_metabochip \
	--reml \
	--reml-no-lrt \
	--pheno ../../randomise_data/phen.txt \
	--mpheno 4 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/crp_metabochip \
	--thread-num 4

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../randomise_data/phen.txt \
	--mpheno 4 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/bmi_hm3_metabochip \
	--thread-num 4


# Hypertension
gcta64 \
	--grm ../data/geno_hm3 \
	--reml \
	--reml-no-lrt \
	--pheno ../../randomise_data/phen.txt \
	--mpheno 5 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/hyp_hm3 \
	--thread-num 5

gcta64 \
	--grm ../data/geno_metabochip \
	--reml \
	--reml-no-lrt \
	--pheno ../../randomise_data/phen.txt \
	--mpheno 5 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/crp_metabochip \
	--thread-num 5

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../randomise_data/phen.txt \
	--mpheno 5 \
	--qcovar ../../randomise_data/covars.txt \
	--out ../results/bmi_hm3_metabochip \
	--thread-num 5


# Bivariate analysis
