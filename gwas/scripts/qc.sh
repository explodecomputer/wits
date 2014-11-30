#!/bin/bash

source ../../config

# Perform simple QC
# Don't need to run this!!

plink1.90 \
	--bfile /global/geneticepi/geno \
	--maf 0.01 \
	--hwe 1e-6 \
	--geno 0.05 \
	--make-bed \
	--out /global/geneticepi/geno_qc


# Get summary statistics

plink1.90 \
	--bfile /global/geneticepi/geno_qc \
	--freq \
	--missing \
	--hardy \
	--out ../results/geno_qc


