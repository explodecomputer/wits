set.seed(1002)
library(fGarch)

standardise <- function(x)
{
	(x - mean(x, na.rm=T)) / sd(x, na.rm=T)
}

# Execute ~/repo/sa_course/randomise_data/generate_randomised_shuffled.sh
# Execute ~/repo/sa_course/randomise_data/phen/genetic_values.sh

# Read in genetic profiles

sbp_gen <- read.table("~/repo/sa_course/randomise_data/phen/sbp.profile", he=T)
dbp_gen <- read.table("~/repo/sa_course/randomise_data/phen/dbp.profile", he=T)
crp_gen <- read.table("~/repo/sa_course/randomise_data/phen/crp.profile", he=T)
bmi_gen <- read.table("~/repo/sa_course/randomise_data/phen/bmi.profile", he=T)

bp_poly <- read.table("~/repo/sa_course/randomise_data/phen/bp_poly.profile", he=T)
crp_poly <- read.table("~/repo/sa_course/randomise_data/phen/crp_poly.profile", he=T)
bmi_poly <- read.table("~/repo/sa_course/randomise_data/phen/bmi_poly.profile", he=T)

gen <- data.frame(FID=sbp_gen$FID, IID=sbp_gen$IID, sbp=sbp_gen$SCORE, dbp=dbp_gen$SCORE, crp=crp_gen$SCORE, bmi=bmi_gen$SCORE, bmip=bmi_poly$SCORE, bpp=bp_poly$SCORE, crpp=crp_poly$SCORE)

fam <- read.table("~/repo/sa_course/randomise_data/geno.fam")
sex <- as.numeric(as.character(fam$V5))
n <- nrow(gen)

pcs <- read.table("~/repo/sa_course/randomise_data/geno_hm3.eigenvec")

# Simulate BMI
# Assume genetic profile explains 8% of variance and poly explains 15%
# Give BMI skewed distribution

bmi <- standardise(gen$bmi) * sqrt(0.06) + 
	standardise(gen$bmip) * sqrt(0.15) + 
	rsnorm(n, 0, sqrt(1-0.06-0.15), 10)

bmi <- (bmi - mean(bmi))/sd(bmi)

bmi[sex == 1] <- bmi[sex == 1] * 6.15 + 27.7
bmi[sex == 2] <- bmi[sex == 2] * 4.73 + 29.0

sbmi <- sd(bmi)
mbmi <- mean(bmi)
bmi <- (bmi - mean(bmi))/sd(bmi)




## The network looks something like this:

## Age is not a confounder for any of the variables
## Sex is associated (2% var) with sbp and dbp
## BMI causes CRP and BP
## CRP and BP are associated but not causally
## BMI explains all but 0.01 of sbp-crp correlation and 0.001 dbp-crp correlation
# bmi -> crp 0.125
# bmi -> sbp 0.058
# bmi -> dbp 0.061
# crp <-> sbp 0.01
# crp <-> dbp 0.001
# h2 of BMI

# rg_bmi-crp = 0.3
# rg_bmi-bp = 0.3
# rg_bp-crp=0


# Create BMI-independent confounders for crp-bp
crpsbp <- rnorm(n, sd=sqrt(0.01))
crpdbp <- rnorm(n, sd=sqrt(0.001))

# Construct CRP
crp <- crpsbp + 
	crpdbp + 
	bmi * sqrt(0.125) + 
	standardise(gen$crpp) * sqrt(0.3) + 
	standardise(gen$crp) * sqrt(0.06) + 
	rnorm(n, 0, sqrt(1 - 0.01 - 0.001 - 0.125 - 0.3 - 0.06))


# Simulate SBP and DBP

# Simple method without using BMI and unknown confounders
# dbp <- rnorm(n, 83.3, 11.7) + bmi * sqrt(0.061) + crpsbp
# ds <- abs(rnorm(n, 57.7, 16.5))
# sbp <- dbp + ds + bmi * sqrt(0.058)
# cor(dbp, sbp)

dbp <- rnorm(n, 0, sqrt(1 - 0.061 - 0.001 - 0.5)) + 
	standardise(bmi) * sqrt(0.061) + 
	crpsbp + 
	gen$dbp +
	standardise(gen$bpp) * sqrt(0.5) +
	sex * 0.1

ds <- abs(rnorm(n, 0, sqrt(1/0.21-1)))

sbp <- dbp + 
	ds + 
	standardise(bmi) * sqrt(0.02) + 
	gen$sbp + 
	sex * 0.1

cor(dbp, sbp)


# Scale phenotypes

bmi <- bmi * sbmi + mbmi
dbp <- dbp * 11.7 + 80.3
sbp <- sbp * 20.4 + 120.97
crp <- crp * 0.838 + 0.560
hscrp <- exp(crp)
hypertension <- as.numeric(dbp > 90 | sbp > 140) + 1
table(hypertension)
age <- as.integer(rnorm(n, 45, 3))







phen <- data.frame(fid=fam$V1, iid=fam$V2, bmi=bmi, dbp=dbp, sbp=sbp, crp=hscrp, hypertension=hypertension)

covars <- pcs
covars$age <- age
covars$sex <- sex

# Check that instruments are associated with what we expect
# summary(lm(crp ~ gen$crp))
# summary(lm(crp ~ gen$bmip + gen$bmi))
# summary(lm(crp ~ gen$crp + gen$crpp))

# summary(lm(bmi ~ gen$bmip + gen$bmi))


# summary(lm(sbp ~ gen$bmi))
# summary(lm(dbp ~ gen$bmi))
# summary(lm(hypertension ~ gen$bmi))
# summary(lm(bmi ~ gen$crp))
# summary(lm(sbp ~ gen$crp))
# summary(lm(dbp ~ gen$crp))
# summary(lm(sbp ~ gen$sbp))
# summary(lm(dbp ~ gen$dbp))
# summary(lm(crp ~ gen$dbp))
# summary(lm(crp ~ gen$sbp))


save(phen, covars, file="~/repo/sa_course/randomise_data/phen.RData")
write.table(phen, "~/repo/sa_course/randomise_data/phen.txt", row=F, col=F, qu=F)
write.table(covars, "~/repo/sa_course/randomise_data/covars.txt", row=F, col=F, qu=F)

# Expected 0.125
cor(bmi, crp)^2

# Expected 0.06
cor(bmi, sbp)^2

# Expected 0.06
cor(bmi, dbp)^2

# Expected 0.01
cor(crp, sbp)^2

# Expected 0.01
cor(crp, dbp)^2

