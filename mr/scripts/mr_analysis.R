library(systemfit)


################
# Load in data #
################

# Phenotypes (previously transformed to normality etc from GWAS stuff)
# Remember: BMI and CRP are log2 transformed
phen <- read.table("../../gwas/data/phen.txt")
names(phen) <- c("FID", "IID", "bmi", "crp", "hyp")

# Covariates
covs <- read.table("../../randomise_data/covars.txt")
names(covs) <- c("FID", "IID", paste("PC", 1:10, sep=""), "age", "sex")

# Instruments
load("../data/instruments.RData")
# Loads in objects: bmisnps, crpsnps


##############################
# Observational associations #
##############################

# Is there an association between the exposure and the outcome?
summary(lm(crp ~ bmi, phen))
plot(crp ~ bmi, phen)


################################
# Associated with confounders? #
################################

summary(lm(phen$crp ~ as.matrix(covs[,-c(1,2)])))
summary(lm(phen$bmi ~ as.matrix(covs[,-c(1,2)])))

# Does the association remain after adjusting for confounders?
summary(lm(crp ~ bmi, phen))
summary(lm(crp ~ bmi + as.matrix(covs[,-c(1,2)]), phen))


###########################
# Instrument associations #
###########################

summary(lm(phen$bmi ~ as.matrix(bmisnps[,-c(1,2)])))


################################################
# Are instruments associated with confounders? #
################################################

summary(lm(bmisnps$FTO ~ as.matrix(covs[,-c(1,2)])))
summary(lm(bmisnps$MC4R ~ as.matrix(covs[,-c(1,2)])))


##################################
# Calculate power of MR analysis #
##################################

# Online power calculator:
# http://glimmer.rstudio.com/kn3in/mRnd/

# Will need the following information:

# Sample size
# Regression coefficient for observational association
# Variance of exposure
# Variance of outcome
# Variance of exposure explained by instrument


################################################
# Are instruments associated with the outcome? #
################################################

summary(lm(phen$crp ~ bmisnps$FTO))
summary(lm(phen$crp ~ bmisnps$MC4R))






summary(lm(phen$bmi ~ as.matrix(crpsnps[,-c(1,2)])))

summary(lm(phen$crp ~ as.matrix(bmisnps[,-c(1,2)])))
summary(lm(phen$hyp ~ as.matrix(bmisnps[,-c(1,2)])))


# Use multiple SNPs to make allelic score

# How does this affect the power?
# How does this affect the precision of the 2SlS estimate?
# What are the possible drawbacks?


# Try performing 

# Try coding up the two stage least squares regression without the use of the systemfit function