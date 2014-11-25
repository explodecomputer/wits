library(ggplot2)

hm3 <- read.table("1kg_hm3.eigenvec")
met <- read.table("1kg_metabochip.eigenvec")
sam <- read.table("sampleinfo.txt", he=T)

nom <- c("FID", "IID", paste("PC", 1:20, sep=""))
names(met) <- names(hm3) <- nom


pccor <- array(0, c(20,20))
pccor <- expand.grid(met=1:20, hm3=1:20, r=NA)
for(i in 1:nrow(pccor))
{
	pccor$r[i] <- cor(hm3[,pccor$hm3[i]+2], met[,pccor$met[i]+2])
}


ggplot(pccor, aes(hm3, met)) +
geom_point(aes(size=r^2)) +
labs(y="Metabochip PCs", x="HapMap3 PCs", size=expression(R^2))
ggsave("images/met_vs_hm3_cors.pdf")


hm3$index <- 1:nrow(hm3)
hm3 <- merge(hm3, sam, by.x="FID", by.y="Sample")
hm3 <- hm3[order(hm3$index),]

met$index <- 1:nrow(met)
met <- merge(met, sam, by.x="FID", by.y="Sample")
met <- met[order(met$index),]

met$snps <- "Metabochip"
hm3$snps <- "HapMap3"

com <- rbind(met, hm3)


ggplot(com, aes(x=PC1, y=PC2)) +
geom_point(aes(colour=Population)) +
facet_grid(. ~ snps)
ggsave("images/PC1-PC2.pdf", width=10, height=6)

ggplot(com, aes(x=PC3, y=PC4)) +
geom_point(aes(colour=Population)) +
facet_grid(. ~ snps)
ggsave("images/PC3-PC4.pdf", width=10, height=6)

ggplot(com, aes(x=PC5, y=PC6)) +
geom_point(aes(colour=Population)) +
facet_grid(. ~ snps)
ggsave("images/PC5-PC6.pdf", width=10, height=6)

ggplot(com, aes(x=PC7, y=PC8)) +
geom_point(aes(colour=Population)) +
facet_grid(. ~ snps)
ggsave("images/PC7-PC8.pdf", width=10, height=6)

ggplot(com, aes(x=PC9, y=PC10)) +
geom_point(aes(colour=Population)) +
facet_grid(. ~ snps)
ggsave("images/PC9-PC10.pdf", width=10, height=6)

ggplot(com, aes(x=PC11, y=PC12)) +
geom_point(aes(colour=Population)) +
facet_grid(. ~ snps)
ggsave("images/PC11-PC12.pdf", width=10, height=6)

ggplot(com, aes(x=PC13, y=PC14)) +
geom_point(aes(colour=Population)) +
facet_grid(. ~ snps)
ggsave("images/PC13-PC14.pdf", width=10, height=6)

ggplot(com, aes(x=PC15, y=PC16)) +
geom_point(aes(colour=Population)) +
facet_grid(. ~ snps)
ggsave("images/PC15-PC16.pdf", width=10, height=6)

ggplot(com, aes(x=PC17, y=PC18)) +
geom_point(aes(colour=Population)) +
facet_grid(. ~ snps)
ggsave("images/PC17-PC18.pdf", width=10, height=6)

ggplot(com, aes(x=PC19, y=PC20)) +
geom_point(aes(colour=Population)) +
facet_grid(. ~ snps)
ggsave("images/PC19-PC20.pdf", width=10, height=6)
