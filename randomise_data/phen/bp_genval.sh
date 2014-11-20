#!/bin/bash

set -e

plink1.90 --bfile ~/repo/sa_course/randomise_data/data --extract ~/repo/sa_course/randomise_data/bp/sbp.txt --make-bed --out ~/repo/sa_course/randomise_data/bp/bp

gcta64 --bfile ~/repo/sa_course/randomise_data/bp/bp --simu-qt --simu-causal-loci dbp.txt --simu-hsq 1 --out dbp
gcta64 --bfile ~/repo/sa_course/randomise_data/bp/bp --simu-qt --simu-causal-loci sbp.txt --simu-hsq 1 --out sbp
