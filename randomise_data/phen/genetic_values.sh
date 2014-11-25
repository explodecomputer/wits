#!/bin/bash

set -e

## GWAS results

plink1.90 --bfile ~/repo/sa_course/randomise_data/geno --score ~/repo/phenome_mining/profiles/gwas/diastolic_blood_pressure.txt --out ~/repo/sa_course/randomise_data/phen/dbp

plink1.90 --bfile ~/repo/sa_course/randomise_data/geno --score ~/repo/phenome_mining/profiles/gwas/systolic_blood_pressure.txt --out ~/repo/sa_course/randomise_data/phen/sbp

plink1.90 --bfile ~/repo/sa_course/randomise_data/geno --score ~/repo/phenome_mining/profiles/gwas/bmi.txt --out ~/repo/sa_course/randomise_data/phen/bmi

plink1.90 --bfile ~/repo/sa_course/randomise_data/geno --score ~/repo/phenome_mining/profiles/gwas/crp.txt --out ~/repo/sa_course/randomise_data/phen/crp


## Polygenic effects

R --no-save --args ~/repo/mQTL-partitioning/grm/alspac_hm3_mothers.bim 10000 ~/repo/sa_course/randomise_data/phen/bp_poly.effects < ~/repo/sa_course/randomise_data/phen/polygenic_effects.R
plink1.90 --bfile ~/repo/sa_course/randomise_data/geno --score ~/repo/sa_course/randomise_data/phen/bp_poly.effects --out ~/repo/sa_course/randomise_data/phen/bp_poly

R --no-save --args ~/repo/mQTL-partitioning/grm/alspac_hm3_mothers.bim 10000 ~/repo/sa_course/randomise_data/phen/bmi_poly.effects < ~/repo/sa_course/randomise_data/phen/polygenic_effects.R
plink1.90 --bfile ~/repo/sa_course/randomise_data/geno --score ~/repo/sa_course/randomise_data/phen/bmi_poly.effects --out ~/repo/sa_course/randomise_data/phen/bmi_poly

R --no-save --args ~/repo/mQTL-partitioning/grm/alspac_hm3_mothers.bim 10000 ~/repo/sa_course/randomise_data/phen/crp_poly.effects < ~/repo/sa_course/randomise_data/phen/polygenic_effects.R
plink1.90 --bfile ~/repo/sa_course/randomise_data/geno --score ~/repo/sa_course/randomise_data/phen/crp_poly.effects --out ~/repo/sa_course/randomise_data/phen/crp_poly


