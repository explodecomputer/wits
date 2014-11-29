load("../../randomise_data/phen.RData")

# These data have been simulated based on distributions estimated from a Danish general population study

# For details of the simulation see simulation "construct_phen.R" script

# There is no missing data
sum(is.na(phen))
sum(is.na(covars))


# distribution of BMI
hist(phen$bmi)

# log transform makes it normal
hist(log(phen$bmi))
phen$lbmi <- log(phen$bmi)

# Which covariates should be included
summary(lm(phen$lbmi ~ as.matrix(covars[,-c(1:2)])))

tapply(phen$lbmi, covars$sex, mean)
tapply(phen$lbmi, covars$sex, sd)

# Significant difference in mean and variance between sexes
# By definition BMI has different variances between sexes because it is 
# weight / height^2, and average height is different in males and females

# Adjust for sex 

# Function to standardise values to have mean 0 and variance 1
standardise <- function(x)
{
	(x - mean(x, na.rm=T)) / sd(x, na.rm=T)
}


phen$bmi_adjusted <- phen$lbmi

# standardise males
index <- covars$sex==1
phen$bmi_adjusted[index] <- standardise(phen$bmi_adjusted[index])

# standardise females
index <- covars$sex==2
phen$bmi_adjusted[index] <- standardise(phen$bmi_adjusted[index])

# No more association of mean or variance with sex
tapply(phen$bmi_adjusted, covars$sex, mean)
tapply(phen$bmi_adjusted, covars$sex, sd)

# Still looks normal
hist(phen$bmi_adjusted)

######

# CRP distribution
hist(phen$crp)

# log transform
hist(log(phen$crp))

# note: logging zero values is to be avoided!
table(phen$crp == 0) # No zero values here
phen$lcrp <- log(phen$crp)

# Associated with covariates
summary(lm(phen$lcrp ~ as.matrix(covars[,-c(1:2)])))

tapply(phen$lcrp, covars$sex, mean)
tapply(phen$lcrp, covars$sex, sd)

# probably ok to just fit sex as a covariate


#######

# Hypertension
table(phen$hypertension) # This is a population study, and hypertension has high prevalence

# Perform logistic regression to test for association with covariates
summary(glm(I(phen$hypertension-1) ~ as.matrix(covars[,-c(1:2)]), family="binomial"))

# Save adjusted phenotypes
phen <- with(phen, data.frame(fid, iid, bmi_adjusted, lcrp, hypertension))
write.table("../data/phen.txt", row=F, col=F, qu=F)
