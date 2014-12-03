Mendelian randomisation practical
=================================

## Background

We have three traits:

- BMI
- CRP
- Blood pressure

Our aim is to find if there are associations between these traits, and estimate the causal effects of these associations using Mendelian Randomisation (MR)

The steps to perform MR in a rigorous manner are outlined below


## Performing MR

### Are the traits associated observationally

We can test this by simply testing for associations between the traits. If there are associations then this could be due to either

- A causal effect
- A reverse causal effect
- An influence of a confounder

Indeed, confounders could have influences in addition to the direct causal effects

### Traits associated with confounders?

A clue as to the possible influence of confounders is to test if there are observational associations between the traits and confounders. However, a lack of observational associations can't rule out the possibility that other unmeasured confounders exist.


### Test instrument associations

In order for MR to work we need a valid instrument for the exposure. This means that the instrument must satisfy the following conditions:

1. The instrument must influence the exposure directly
2. The instrument must only influence the outcome through the exposure
3. After conditioning on any observed confounders the instrument is independent of unobserved confounders

It is often difficult for an instrument completely satisfies these conditions. But we can make sure that the instrument has an influence on the exposure through a plausible biological mechanism.


### Calculate power of the MR analysis

The success of MR is greatly dependent upon power. It is easy to think about MR power intuitively:
If the exposure is causal then it's instrument should have an influence on the outcome. The magnitude of this influence is simply the variance of the exposure explained by the instrument multiplied by the variance of the outcome explained by the exposure.

The implementation for a formal estimate of power was turned into an online calculator:
[http://glimmer.rstudio.com/kn3in/mRnd/](http://glimmer.rstudio.com/kn3in/mRnd/)

Will need the following information:

- Sample size
- Regression coefficient for observational association
- Variance of exposure
- Variance of outcome
- Variance of exposure explained by instrument

This can be useful to do because if the power is sufficient and there ISN'T a significant IV association then this can be evidence that the association is not in the hypothesised causal direction.


### Test if instrument is associated with confounders

For satisfying condition 3 stated above.


### Test if SNP is associated with the outcome

This is a useful step to make an inference as to whether or not there is a potential causal effect.


## MR estimation

Here we formally estimate the causal effect of the instrument on the outcome that is occurring through the exposure. In this example we will use two stage least squares to obtain the causal estimate. The estimate is simply calculated through:

		X = a1 + hat(b1)Z + E1
		hat(X) = hat(b1)Z
		Y = a2 + hat(b2)hat(X) + E2

where hat(b2) is our estimate of the instrument's effect.

Note:
2SLS is only one of several approaches that can be used - it deals 

### Estimate causal effect of exposure on outcome

If the observational association between exposure and outcome is at least partly causal, and the IV estimate is the estimate of the instrument's effect on the outcome through the exposure, then we can estimate the true causal effect of the exposure on the outcome using the IV ratio estimate. First, calculate the proportion of the observational association that is indeed causal:

		ratio = hat(b2) / hat(b_obs)

Then we can scale the observational association by this ratio
		
		hat(b_causal) = ratio x hat(b_obs)


## Setup

Update the repository

		cd ~/wits
		git pull

Make sure that the QC'd phen file from the GWAS is available, i.e. run:

		cd ~/wits/gwas/scripts/
		R --no-save < qc.R

Look at the GWAS results for BMI, CRP and hypertension. The top SNPs are going to be our 'instruments'. We used clumping to isolate a single SNP per peak. Run the following command to extract instruments for BMI and CRP:

		cd ~/wits/mr/scripts
		./extract_instruments.sh

The necessary code to run the rest of the analyses below are in the file `mr_analysis.R`.

## Exercises

1. Calculate the causal effects of 
	- BMI on CRP
	- CRP on BMI
	- BMI on Blood pressure
	- CRP on Blood pressure

2. Calculate the change in power from using a single instrument to using multiple instruments

3. Use multiple SNPs to make allelic scores for BMI and CRP
	- How does this affect the power?
	- How does this affect the precision of the 2SLS estimate?
	- What are the possible drawbacks?

4. Code up the two stage least squares regression without the use of the systemfit function

5. What is a good way to graphically represent these results?
