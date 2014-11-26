library(ggplot2)

chip <- read.table("../gwas_example/bmi_geno.qassoc.gz", he=T)
imp <- read.table("../gwas_example/bmi_1kg.qassoc.gz", he=T)

chip$type <- "Genotyped"
imp$type <- "Imputed"
dat <- rbind(chip, imp)

index <- 675:875
r <- range(chip$BP[index])

ggplot(subset(dat, BP > r[1] & BP < r[2]), aes(BP, -log10(P))) +
geom_point() +
facet_grid(type ~ .) +
geom_hline(yintercept=-log10(5e-8))
ggsave(file="../gwas_example/manhattan.pdf")
