source("~/repo/explodecomputr/R/functions.R")

arguments <- commandArgs(T)
bimfile <- arguments[1]
nsnp <- as.numeric(arguments[2])
outfile <- arguments[3]

bim <- readBim(bimfile)
index <- sample(1:nrow(bim), nsnp, replace=FALSE)
snplist <- subset(bim, select=c(SNP, A1))[index, ]
snplist$effect <- rnorm(nsnp)

write.table(snplist, file=outfile, row=F, col=F, qu=F)
