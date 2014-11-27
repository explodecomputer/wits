#!/bin/bash

# Calculate BLUP solutions for the SNP effects using training set


head -n 7000 ../../randomise_data/geno.fam > ../data/trainingset.txt
tail -n 1237 ../../randomise_data/geno.fam > ../data/testingset.txt

gcta64 \
	--grm ../data/geno_hm3 \
	--keep ../data/trainingset.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../randomise_data/phen.txt \
	--mpheno 1 \
	--qcovar ../../randomise_data/covars.txt \
	--reml-pred-rand \
	--out ../results/bmi_hm3 \
	--thread-num 4

gcta64 --bfile ../../randomise_data/geno \
	--keep ../data/trainingset.txt \
	--extract ../data/hapmap3_autosome.snplist \
	--blup-snp ../results/bmi_hm3.indi.blp \
	--out ../results/bmi_hm3

plink1.90 --bfile ../../randomise_data/geno \
	--extract ../data/hapmap3_autosome.snplist \
	--score ../results/bmi_hm3.snp.blp \
	--keep ../data/testingset.txt \
	--out ../results/bmi_hm3_predicted

