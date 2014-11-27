load("../../randomise_data/phen.RData")
pred <- read.table("../results/bmi_hm3_predicted.profile",he=T)

phen <- merge(phen, pred, by.x="fid", by.y="FID")
cor(phen$bmi, phen$SCORE)
