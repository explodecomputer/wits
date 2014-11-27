readGRM <- function(rootname)
{
	bin.file.name <- paste(rootname, ".grm.bin", sep="")
	n.file.name <- paste(rootname, ".grm.N.bin", sep="")
	id.file.name <- paste(rootname, ".grm.id", sep="")

	cat("Reading IDs\n")
	id <- read.table(id.file.name)
	n <- dim(id)[1]
	cat("Reading GRM\n")
	bin.file <- file(bin.file.name, "rb")
	grm <- readBin(bin.file, n=n*(n+1)/2, what=numeric(0), size=4)
	close(bin.file)
	cat("Reading N\n")
	n.file <- file(n.file.name, "rb")
	N <- readBin(n.file, n=n*(n+1)/2, what=numeric(0), size=4)
	close(n.file)

	cat("Creating data frame\n")
	l <- list()
	for(i in 1:n)
	{
		l[[i]] <- 1:i
	}
	col1 <- rep(1:n, 1:n)
	col2 <- unlist(l)
	grm <- data.frame(id1=col1, id2=col2, N=N, grm=grm)	

	ret <- list()
	ret$grm <- grm
	ret$id <- id
	return(ret)
}


hm3 <- readGRM("../data/geno_hm3")
met <- readGRM("../data/geno_metabochip")


# What does the matrix look like?
head(hm3$grm, 20)

# Distribution of diagonals
pdf("../images/hm3_diags.pdf")
hist(subset(hm3$grm, id1 == id2)$grm)
dev.off()

pdf("../images/met_diags.pdf")
hist(subset(met$grm, id1 == id2)$grm)
dev.off()

png("../images/met_hm3_diags.png")
plot(subset(met$grm, id1 == id2)$grm, subset(hm3$grm, id1 == id2)$grm)
dev.off()


# Distribution of off-diagonals
pdf("../images/hm3_odiags.pdf")
hist(subset(hm3$grm, id1 != id2)$grm[1:100000])
dev.off()

pdf("../images/met_odiags.pdf")
hist(subset(met$grm, id1 != id2)$grm[1:100000])
dev.off()

png("../images/met_hm3_odiags.png")
plot(subset(met$grm, id1 == id2)$grm[1:1000000], subset(hm3$grm, id1 == id2)$grm[1:1000000])
abline(lm(subset(hm3$grm, id1 == id2)$grm[1:1000000] ~ subset(met$grm, id1 == id2)$grm[1:1000000]), col="red")
dev.off()

