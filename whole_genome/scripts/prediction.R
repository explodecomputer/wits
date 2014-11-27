load("../../randomise_data/phen.RData")
pred <- read.table("../results/bmi_hm3_predicted.profile",he=T)

phen <- merge(phen, pred, by.x="fid", by.y="FID")
cor(phen$bmi, phen$SCORE)^2

# How does this compare to expectation?

# Assume 1 million independent causal effects:

h2=0.25
m=1e6
n=7000

# expected prediction accuracy:
h2 / (1 + m / (n * h2))

# Try different values of m to make an estimate of the number of independent causal effects
