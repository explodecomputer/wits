arguments <- commandArgs(T)
leg <- arguments[1]
snplist <- arguments[2]
chr <- arguments[3]

leg <- read.table(leg, colClass=c("character", "numeric"))
snplist <- read.table(snplist)

leg$code <- paste("chr", chr, ":", leg$V2, sep="")
leg$index <- 1:nrow(leg)
leg <- merge(leg, snplist, by.x="code", by.y="V1")
leg <- leg[order(leg$index),]

write.table(leg, file=paste("leg", chr, ".txt", sep=""), row=F, col=F, qu=F)
