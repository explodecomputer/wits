# Simulate SBP and DBP

n <- 8237
dbp <- rnorm(n, 83.3, 11.7)
ds <- abs(rnorm(n, 57.7, 16.5))
sbp <- dbp + ds
cor(dbp, sbp)

# Need genetic values for sbp and dbp
# Execute ~/repo/sa_course/randomise_data/generate_randomised_shuffled.sh
# Execute ~/repo/sa_course/randomise_data/bp/bp_genval.sh

a <- read.table("~/repo/sa_course/randomise_data/bp/sbp.phen")
b <- read.table("~/repo/sa_course/randomise_data/bp/dbp.phen")

vgs <- 0.0007 * var(sbp)
a$sbp <- sbp + ((a$V3 - mean(a$V3))/sd(a$V3))*sqrt(vgs)

vgd <- 0.0009 * var(dbp)
b$dbp <- dbp + ((b$V3 - mean(b$V3))/sd(b$V3))*sqrt(vgd)

hypertension <- as.numeric(b$dbp > 90 | a$sbp > 140)