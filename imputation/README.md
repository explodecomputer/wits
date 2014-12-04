Imputation practical
====================

## Background

We have SNP data from a genotyping chip, but we would like something approaching sequence level data for these individuals. We can infer the genotypes 'missing' from the SNP chip by imputing using a reference dataset.

For a full pipeline to perform imputation, from QC to post processing, see [https://github.com/explodecomputer/imputePipe/](https://github.com/explodecomputer/imputePipe/)

Here we will perform imputation of a 1Mb region around the FTO gene

## Perform imputation

### Data setup

- Need to get the reference data
	- Phased haplotypes
	- Genetic map

- Target genotype data
	- Make sure adequately QC'd
	- All SNPs are on positive strand
	- All SNPs have b37 coordinates

All of these steps have already been done

### Phase target data

Use [ShapeIt version 2](http://www.shapeit.fr/) to perform phasing. There are a number of parameters that can be altered which when left as default should perform just fine, but it may be interesting to see how they affect imputation accuracy.

- ne
- iterations
- states
- window


### Perform imputation

Use [Impute2](https://mathgen.stats.ox.ac.uk/impute/impute_v2.html#home) to perform the imputation of phased target data against the 1000 genomes reference panel. Again, the default settings are typically fine but we could see how altering these might influence imputation accuracy:

- iter / burnin
- Ne
- k_hap

Following imputation create a dataset that is in plink format, filtered on MAF > 0.01 and info score > 0.8.


## Exercises

1. Perform imputation of the 1Mb region around the FTO gene
	
		cd ~/wits/imputation/scripts
		./extract_data.sh
		./haplotyping.sh
		./imputing.sh

2. Evaluate the quality metrics. How sensitive is imputation to each of the settings that were varied? Consider:

	- concordance table (see `../data/imputed_ftoregion_summary`)
	- distribution of info scores (see `analyse_imputation.R`)


3. Plot the distribution of imputed allele frequencies against the original genotype frequencies. Why are there so many rare variants in 1000 genomes data? See `analyse_imputation.R`.

4. Plot the relationship of minor allele frequency against quality score. See `analyse_imputation.R`. Why are rare alleles harder to impute?

5. Compare the GWAS performance of imputed data against genotype data.
	
	- Run GWAS on region and look at the new Manhattan plots in `../gwas_comparison`. Run the following to generate:
	
			./gwas_comparison.sh
			R --no-save < gwas_comparison.R

6. Upload FTO GWAS results to [LocusZoom](https://statgen.sph.umich.edu/locuszoom/genform.php?type=yourdata) to generate plots of region
