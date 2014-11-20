#!/bin/bash

set -e
cd ~/repo/sa_course/randomise_data

# Extract unrelated kids from imputed data
# Permute fam file rows for each chromosome
for i in {1..23}
do
	plink1.90 --bfile ~/1kg_scratch/chr${i}/alspac_1kg_p1v3_${i}_maf0.01_info0.8 --keep ~/1kg_scratch/docs/Unrelateds/CHILDREN_UNRELATED_PLINK.txt --make-bed --out scratch/chr${i}
	cp scratch/chr${i}.fam scratch/chr${i}.fam.orig
	cat scratch/chr${i}.fam.orig | shuf > scratch/chr${i}.fam
done

# Create merge file
echo "scratch/chr2.bed scratch/chr2.bim scratch/chr2.fam" > mergefile.txt
for i in {3..23}
do
	echo "scratch/chr${i}.bed scratch/chr${i}.bim scratch/chr${i}.fam" >> mergefile.txt
done

# Merge chromosomes into one file
plink1.90 --bfile scratch/chr1 --merge-list mergefile.txt --make-bed --out unrelateds

# Make fake IDs
cp unrelateds.fam unrelateds.fam.orig
nl unrelateds.fam.orig | awk '{ print "id"$1, "id"$1, "0", "0", $6, $7 }' > unrelateds.fam
