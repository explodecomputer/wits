#!/bin/bash

d="~/data/1000g_reference/no_singletons/ALL.integrated_phase1_v3.20101123.snps_indels_svs.genotypes.nosing"

for i in {1..22}
do
	echo ${i}
	zcat $d/ALL.chr${i}.integrated_phase1_v3.20101123.snps_indels_svs.genotypes.nosing.legend.gz | sed 1d | cut -d " " -f 1-2 > chr${i}.leg
	R --no-save --args chr${i}.leg metabochip_b37.txt ${i} < metabochip_rsids.R
done

rm -f metabochip_rsids.txt
touch metabochip_rsids.txt
for i in {1..22}
do
	echo ${i}
	awk -v x=${i} '{ print x, $2, $3, $1 }' leg${i}.txt >> metabochip_rsids.txt
done
