Genome wide association studies
===============================

## Background

This practical is a quick refresher on how to perform GWAS. We are not starting at the beginning - the genotypes are already cleaned and imputed, and we have phenotypes, principal components and other covariates ready to use. Population outliers have already been removed also.


## A note about Plink2

Most of the data manipulation and some of the analysis will be run using [plink2](https://www.cog-genomics.org/plink2/). It is currently in beta (technically still `plink1.90`), but for most functions is stable and is extremely fast compared to the [original plink](http://pngu.mgh.harvard.edu/~purcell/plink/).


## Data

Some things to consider before starting the analysis:


### Genotype data

- How many individuals are there?
- How many SNPs?
- How many chromosomes?
- Genotyped or imputed?
- What is the SNP density?
- What format is the data?
- Is there population structure?
- Are there related individuals?


### Phenotype data

- Is the trait continuous or dichotomous?
- How have the subjects been chosen?
- Are there covariates?
- How many individuals with genotype, trait and covariate data?


## Quality control

Performing QC is very important, here are some routine things to consider:

- Are SNPs in Hardy Weinburg Equilibrium
- Remove low MAF SNPs (e.g. < 0.01)
- Remove individuals and SNPs with high missingness (e.g. > 0.05)
- Phenotypes should be normalised
- Some variables should be adjusted for variance effects
- Identify population outliers


### Things that need reporting
- Genotyping call rate after exclusions
- Number of individuals and SNPs after exclusions
- Trait distribution


## Performing GWAS

Ideally we would use a proper linear model but in the interests of time we will use a fast score statistic

Should include covariates and PCs

## Post processing

- Significance thresholds
- Manhattan plot
- Q-Q plot
- Clumping


## Questions
1. Perform QC steps for the genotype data, and save the cleaned genotype data with filename `geno_qc`

        cd ~/wits/gwas/scripts
        ./qc.sh

2. Perform QC steps for the phenotype data

        R --no-save < qc.R

3. Perform the GWAS.

        ./gwas.sh

4. How many independent significant signals are identified for each trait? What is a suitable threshold? Look at the Manhattan plots in `../images` and at the `.clumped` files in `../results`.

5. Is there evidence for the signals being driven by population stratification? Use the estimates of `lambda` in the Q-Q plots.
6. What is the best way to verify whether these signals are real?
7. Are the effect size estimates likely to be accurate?
