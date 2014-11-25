library(qqman)

qqplotpval <- function(P, filename=NULL)
{
        require(GenABEL)
        l <- estlambda(P, method="median")
        nom <- paste("lambda = ", round(l$estimate, 3), sep="")
        if(!is.null(filename))
        {
                png(filename)
        }
        estlambda(P, method="median", plot=TRUE, main=nom)
        if(!is.null(filename))
        {
                dev.off()
        }
}

arguments <- commandArgs(T)
infile <- arguments[1]
trait <- arguments[2]

a <- read.table(infile, he=T)
a$CHR <- as.numeric(a$CHR)

qqplotpval(a$P, paste(trait, "_qqplot.png", sep=""))

png(file=paste(trait, "_manhattan.png", sep=""))
manhattan(a, main=paste(trait, "Manhattan plot"))
dev.off()

