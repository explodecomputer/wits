Whole genome methods practical
==============================

## Background

The use of very simple, single SNP approaches have actually been very successful in genetic studies. However, with the introduction of whole genome methods the scope of what we might be able to learn from genetic data has broadened significantly. Here we'll look at some of the fundamentals.


## A note about software

The original implementation for large scale human data is [GCTA](http://www.complextraitgenomics.com/software/gcta/). It is continually improving, and it has a huge number of features. We will use this to perform REML estimation of heritabilities. It also constructs genetic relationship matrices, which is something that we need, but we will use [Plink2](https://www.cog-genomics.org/plink2/) to do this, as it does the same implementation but much faster.


## Using SNPs to estimate kinship

How far removed must two individuals be from one another before they are considered 'unrelated'? We can make estimates of the proportion of the genome that is shared identical by descent (IBD) between all pairs of seemingly unrelated individuals from the population by calculating the proportion of SNPs that are identical by state (IBS). 

The result is a genetic relationship matrix (GRM, aka kinship matrix) of size `n x n`, diagonals are estimates of an individual's inbreeding and off-diagonals are an estimate of genomic similarity for pairs of individuals.


## Using kinships to estimate heritability

See slides for more accurate treatment, but the intuition is as follows. Heritability is the measure of the proportion of variation that is due to genetic variation. If individuals who are more phenotypically similar also tend to be more genetically similar then this is evidence that heritability is non-zero. We can make estimates of heritability by comparing these similarities.

When genetic similarity is calculated by using SNPs then we are no longer estimating heritability per se, we are instead estimating how much of the phenotypic variance can be explained by all the SNPs in our model.

## Setup

Update the repository

    cd ~/wits
    git pull

Put the GCTA programme in your path

    cp bin/gcta64 ~/bin

And make sure you can run it:

    gcta64

If you wish to use pre-computed GRMs instead of recalculating them yourselves then see then copy them from the shared space:

    cp /global/geneticepi/geno_hm3.grm* ~/wits/whole_genome/data/
    cp /global/geneticepi/geno_metabochip.grm* ~/wits/whole_genome/data/

## Exercises

1. Construct the genetic relationship matrix using HM3 SNPs and metabochip SNPs

        cd ~/wits/whole_genome/scripts
        ./construct_grm.sh

2. What are the SNP heritabilities for each of the traits? See `estimate_heritability.sh`
3. Why is it important to make sure related individuals are not included in this analysis?
4. Use BLUP to predict each of the three traits

        ./prediction.sh

5. Estimate the number of SNPs that influence the trait. See `prediction.R`
6. Estimate the heritability fitting the metabochip GRM and whole genome HM3 GRM jointly. See `estimate_heritability.sh`. What can we infer from these results?
7. Perform bivariate analysis to calculate genetic correlations between each pair of traits. See `estimate_heritability.sh`.
8. Construct two GRMs, one using chromosomes 1-8 and another using 9-22. Estimate the heritability of each GRM separately and both combined. Is the sum of heritabilities for each chromosome the same as that for the entire genome?
