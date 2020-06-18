#Use this R code to look at the allele balance
#This is code to sort out loci that are not in allele balance, starting with a script that Evelyn Jensen sent me.
library("vcfR")
#citation("vcfR")

#import vcf file:
gal_vcfR <- read.vcfR("BCFtools_GxE_minQ90_missing_mac3_autosomes_meanDP.recode.vcf", verbose = FALSE )
gt <- extract.gt(gal_vcfR)
hets <- is_het(gt)
# Censor non-heterozygous positions.
is.na(gal_vcfR@gt[,-1][!hets]) <- TRUE
# Extract allele depths.
ad <- extract.gt(gal_vcfR, element = "AD")
ad1 <- masplit(ad, delim = ",", sort = 0, record = 1)
ad2 <- masplit(ad, delim = ",", sort = 0, record = 2)
depth <- (ad1+ad2)
ab<-ad1/(ad1+ad2)
means <- rowMeans(ab, na.rm = TRUE)
stdev <- sd(ab, na.rm = TRUE) 
avg <- mean(ab, na.rm=TRUE)
upper <- (avg+stdev)
upper2 <- (avg+2*stdev) 
upper3 <- (avg+3*stdev) 
lower <- (avg-stdev)
lower2 <- (avg-2*stdev) 
lower3 <- (avg-3*stdev) 
#PLOT:
hist(means,breaks=200,main="Histogram of allele balance\n(autosomes)",xlab="allele balance")
abline(v=upper,col="#009AEB")
abline(v=lower,col="#009AEB")
#choose list and write to file
upper.list <- names(means[means>upper])
lower.list <- names(means[means<lower])
exclude.list <- c(upper.list,lower.list)
write.table(na.omit(exclude.list),file = "BCFtools_GWAS_autosomes_maxDP_AB_exclude.txt",sep=",",quote=F,col.names = FALSE,row.names = FALSE) #table of locus names to exclude

rm(gal_vcfR)
save.image(file = "sc01_pt5_allele_balance.RData")
