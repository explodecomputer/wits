#!/bin/bash


# Perform GWAS on BMI, hypertension, CRP

plink1.90 --bfile geno --assoc --pheno phen.txt --mpheno 1 --out bmi
gcta64 --thread-num 10 --grm geno_hm3 --reml --reml-no-lrt --pheno phen.txt --mpheno 1 --out bmi
Rscript gwas_graphs.R bmi.qassoc BMI


plink1.90 --bfile geno --assoc --pheno phen.txt --mpheno 4 --out crp
gcta64 --thread-num 10 --grm geno_hm3 --reml --reml-no-lrt --pheno phen.txt --mpheno 4 --out crp
Rscript gwas_graphs.R crp.qassoc CRP


plink1.90 --bfile geno --assoc --pheno phen.txt --mpheno 5 --out hypertension
gcta64 --thread-num 10 --grm geno_hm3 --reml --reml-no-lrt --pheno phen.txt --mpheno 5 --out hypertension
Rscript gwas_graphs.R hypertension.assoc Hypertension

plink1.90 --bfile geno --clump bmi.qassoc --clump-kb 1000 --clump-r2 0.1 --out bmi
plink1.90 --bfile geno --clump crp.qassoc --clump-kb 1000 --clump-r2 0.1 --out crp
plink1.90 --bfile geno --clump hypertension.assoc --clump-kb 1000 --clump-r2 0.1 --out hypertension
