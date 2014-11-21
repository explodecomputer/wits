#!/bin/bash

set -e

plink1.90 --bfile ~/repo/sa_course/randomise_data/geno --score ~/repo/phenome_mining/profiles/gwas/diastolic_blood_pressure.txt --out ~/repo/sa_course/randomise_data/phen/dbp

plink1.90 --bfile ~/repo/sa_course/randomise_data/geno --score ~/repo/phenome_mining/profiles/gwas/systolic_blood_pressure.txt --out ~/repo/sa_course/randomise_data/phen/sbp

plink1.90 --bfile ~/repo/sa_course/randomise_data/geno --score ~/repo/phenome_mining/profiles/gwas/bmi.txt --out ~/repo/sa_course/randomise_data/phen/bmi

plink1.90 --bfile ~/repo/sa_course/randomise_data/geno --score ~/repo/phenome_mining/profiles/gwas/crp.txt --out ~/repo/sa_course/randomise_data/phen/crp

