makeInstruments <- function(rootname)
{
	a <- read.table(paste(rootname, ".raw", sep=""), he=T)
	b <- read.table(paste(rootname, ".txt", sep=""), he=F)

	a <- subset(a, select=-c(PAT,MAT, SEX, PHENOTYPE))
	rsid <- do.call(rbind, strsplit(names(a)[-c(1:2)], split="_"))[,1]
	rsid <- data.frame(rsid=rsid, index=1:length(rsid))
	rsid <- merge(rsid, b, by.x="rsid", by.y="V1")
	rsid <- rsid[order(rsid$index), ]
	names(a)[3:ncol(a)] <- as.character(rsid$V2)
	return(a)
}

crpsnps <- makeInstruments("../data/crpsnps")
bmisnps <- makeInstruments("../data/bmisnps")

save(crpsnps, bmisnps, file="../data/instruments.RData")
