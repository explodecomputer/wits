#!/bin/bash

source ../../config

# Calculate BLUP solutions for the SNP effects using training set


head -n 7000 ${datadir}/geno_qc.fam > ../data/trainingset.txt
tail -n 1237 ${datadir}/geno_qc.fam > ../data/testingset.txt

gcta64 \
	--grm ../data/geno_hm3 \
	--keep ../data/trainingset.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--qcovar ../../randomise_data/covars.txt \
	--reml-pred-rand \
	--out ../results/bmi_hm3 \
	--thread-num 8

gcta64 --bfile ${datadir}/geno_qc \
	--keep ../data/trainingset.txt \
	--extract ../data/hapmap3_autosome.snplist \
	--blup-snp ../results/bmi_hm3.indi.blp \
	--out ../results/bmi_hm3 \
	--thread-num 8

plink1.90 --bfile ${datadir}/geno_qc \
	--extract ../data/hapmap3_autosome.snplist \
	--score ../results/bmi_hm3.snp.blp \
	--keep ../data/testingset.txt \
	--out ../results/bmi_hm3_predicted

