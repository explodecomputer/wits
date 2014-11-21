library(fGarch)

# Execute ~/repo/sa_course/randomise_data/generate_randomised_shuffled.sh
# Execute ~/repo/sa_course/randomise_data/phen/genetic_values.sh
# Read in genetic profiles

sbp_gen <- read.table("~/repo/sa_course/randomise_data/phen/sbp.profile", he=T)
dbp_gen <- read.table("~/repo/sa_course/randomise_data/phen/dbp.profile", he=T)
crp_gen <- read.table("~/repo/sa_course/randomise_data/phen/crp.profile", he=T)
bmi_gen <- read.table("~/repo/sa_course/randomise_data/phen/bmi.profile", he=T)

gen <- data.frame(FID=sbp_gen$FID, IID=sbp_gen$IID, sbp=sbp_gen$SCORE, dbp=dbp_gen$SCORE, crp=crp_gen$SCORE, bmi=bmi_gen$SCORE)

fam <- read.table("~/repo/sa_course/randomise_data/data.fam")
sex <- as.numeric(as.character(fam$V5))
n <- nrow(gen)

# Simulate BMI
# Assume genetic profile explains 10% of variance
# Give BMI skewed distribution

bmi <- ((gen$bmi - mean(gen$bmi))/sd(gen$bmi)) * sqrt(0.1) + rsnorm(n, 0, sqrt(0.9), 2)
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

# Create BMI-independent confounders for crp-bp
crpsbp <- rnorm(n, sd=sqrt(0.01))
crpdbp <- rnorm(n, sd=sqrt(0.001))

# Construct CRP
crp <- crpsbp + crpdbp + bmi * sqrt(0.125) + rnorm(n, 0, sqrt(1 - 0.01 - 0.001 - 0.125))

# Simulate SBP and DBP

# Simple method without using BMI and unknown confounders
# dbp <- rnorm(n, 83.3, 11.7) + bmi * sqrt(0.061) + crpsbp
# ds <- abs(rnorm(n, 57.7, 16.5))
# sbp <- dbp + ds + bmi * sqrt(0.058)
# cor(dbp, sbp)

dbp <- rnorm(n, 0, sqrt(1 - 0.061 - 0.001)) + bmi * sqrt(0.061) + crpsbp + gen$dbp + sex * 0.1
ds <- abs(rnorm(n, 0, sqrt(1/0.21-1)))
sbp <- dbp + ds + bmi * sqrt(0.058) + gen$sbp + sex * 0.1
cor(dbp, sbp)


# Scale phenotypes

bmi <- bmi * sbmi + mbmi
dbp <- dbp * 11.7 + 83.3
sbp <- sbp * 20.4 + 140.97
crp <- crp * 0.838 + 0.560
hscrp <- exp(crp)
hypertension <- as.numeric(dbp > 90 | sbp > 140)
age <- as.integer(rnorm(n, 45, 3))

phen <- data.frame(fid=fam$V1, iid=fam$V2, bmi=bmi, dbp=dbp, sbp=sbp, crp=hscrp, hypertension=hypertension, age=age, sex=sex)

# Check that instruments are associated with what we expect
summary(lm(crp ~ gen$bmi))
summary(lm(sbp ~ gen$bmi))
summary(lm(dbp ~ gen$bmi))
summary(lm(hypertension ~ gen$bmi))
summary(lm(bmi ~ gen$crp))
summary(lm(sbp ~ gen$crp))
summary(lm(dbp ~ gen$crp))
summary(lm(sbp ~ gen$sbp))
summary(lm(dbp ~ gen$dbp))
summary(lm(crp ~ gen$dbp))
summary(lm(crp ~ gen$sbp))


save(phen, file="~/repo/sa_course/randomise_data/phen.RData")

