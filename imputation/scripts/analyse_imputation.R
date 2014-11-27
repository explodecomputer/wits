library(ggplot2)
library(plyr)

info <- read.table("../data/imputed_ftoregion_info", he=T)
infos <- read.table("../data/imputed_ftoregion_info_by_sample", he=T)

# What is the imputation quality?
pdf(file="../images/imputation_quality.pdf")
hist(infos$concord_type0)
hist(infos$r2_type0)
dev.off()

# How many SNPs does the region now have?
nrow(info)

# How many were imputed vs how many are original genotypes?
table(info$type)

# Plot minor allele frequency distributions
info$maf <- info$exp_freq_a1
info$maf[info$maf > 0.5] <- 1 - info$maf[info$maf > 0.5]

ggplot(info, aes(x=maf)) +
geom_histogram() +
facet_grid(type ~ ., scales="free_y")
ggsave("../images/maf.pdf")

# Many have frequency of 0
table(info$maf == 0)

ggplot(subset(info, maf!=0), aes(x=maf)) +
geom_histogram() +
facet_grid(type ~ ., scales="free_y")
ggsave("../images/maf_no0.pdf")


# Why does 1000 genomes data have so many rare variants?

# Plot predicted imputation accuracy for each SNP
hist(subset(info, type==0)$info)

# Plot imputation accuracy against maf
png("../images/maf_vs_info.pdf")
plot(info ~ maf, subset(info, type==0))
dev.off()

# average across maf bins:
info$mafbin <- ceiling(info$maf * 100) / 100
dat <- ddply(info, .(mafbin), summarise, info=mean(info))

pdf("../images/mafbin_vs_info.pdf")
plot(info ~ mafbin, dat)
dev.off()

# Why is imputation so bad at imputing rare variants?