#!/bin/bash

# Perform simple QC

plink1.90 \
	--bfile ../../randomise_data/geno \
	--maf 0.01 \
	--hwe 1e-6 \
	--geno 0.05 \
	--make-bed \
	--out ../../randomise_data/geno_qc


# Get summary statistics

plink1.90 \
	--bfile ../../randomise_data/geno_qc \
	--freq \
	--missing \
	--hardy \
	--out ../../randomise_data/geno_qc


