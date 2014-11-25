library(qqman)

readPlinkLinear <- function(filename, h=TRUE)
{
	a <- read.table(filename, header=h, colClass=c("numeric", "character", "numeric", "character", "character", "numeric", "numeric", "numeric", "numeric"))
	if(!h)
	{
		names(a) <- c("CHR", "SNP", "BP", "A1", "TEST", "NMISS", "BETA", "STAT", "P")
	}
	return(a)
}



arguments <- commandArgs(T)
infile <- arguments[1]
trait <- arguments[2]

a <- readPlinkLinear(infile)

png(file=paste(trait, "_qqplot.png", sep=""))
qq(a$P, main=paste(trait, "Q-Q plot"))
dev.off()

png(file=paste(trait, "_manhattan.png", sep=""))
manhattan(a, main=paste(trait, "Manhattan plot"))
dev.off()

