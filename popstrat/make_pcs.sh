#!/bin/bash

# create PCs from HM3
# create PCs from metabochip


plink1.90 --bfile wtccc_controls_1kg --make-grm-bin --extract ~/repo/sa_course/randomise_data/hapmap3_autosome.snplist --out wtccc_controls_hm3

gcta64 --grm wtccc_controls_hm3 --pca --out wtccc_controls_hm3



for i in {1..22}
do
	wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr${i}.phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz
	plink1.90 --vcf ALL.chr${i}.phase3_shapeit2_mvncall_integrated_v5.20130502.genotypes.vcf.gz --make-bed --out chr${i}
done



extractSnps ~/repo/mQTL-partitioning/snplists/hapmap3_autosome.snplist chrCHR 1kg_hm3


for i in {1..22}
do
	echo ${i}
	cp chr${i}.bim chr${i}.bim.orig
	awk '{ print $1, "chr"$1":"$4, $3, $4, $5, $6}' chr${i}.bim.orig > chr${i}.bim
done

awk '{ print "chr"$2":"$3 }' metabochip_b37 > metabochip_b37.txt

extractSnps metabochip_b37.txt chrCHR 1kg_metabochip
extractSnps2 metabochip_b37.txt chrCHR 1kg_metabochip

plink1.90 --make-grm-bin --bfile 1kg_hm3 --maf 0.01 --out 1kg_hm3
plink1.90 --make-grm-bin --bfile 1kg_metabochip --maf 0.01 --out 1kg_metabochip

gcta64 --grm 1kg_hm3 --pca --out 1kg_hm3
gcta64 --grm 1kg_metabochip --pca --out 1kg_metabochip