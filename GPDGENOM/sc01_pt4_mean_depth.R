#This is code to sort out loci that are not in allele balance, starting with a script that Evelyn Jensen sent me.
library("vcfR")
#citation("vcfR")

#Starting with mean depth from VCFtools
ldepth <- read.table(file="BCFtools_GxE_minQ90_missing_mac3_autosomes.ldepth.mean",header=T)
head(ldepth)
#Visualize standard deviation of depth:
depth.lstdev <-  sqrt(ldepth$VAR_DEPTH)
hist(depth.lstdev[depth.lstdev<100],breaks=200)
depth.avg.lstdev <- mean(depth.lstdev, na.rm=TRUE)
#depth.stdev <- depth.avg.lstdev
#visualize means and standard deviation of means:
depth.means <- ldepth$MEAN_DEPTH
depth.stdev <- sd(depth.means, na.rm=TRUE)
depth.avg <- mean(depth.means, na.rm=TRUE)
depth.upper <- (depth.avg+depth.stdev)
depth.upper2 <- (depth.avg+2*depth.stdev) 
depth.upper3 <- (depth.avg+3*depth.stdev) 
#PLOT:
hist(depth.means[depth.means<200],breaks=200,main="Histogram of read depth\n(autosomes)",xlab="Read depth")
abline(v=depth.upper,col="#009AEB")
abline(v=depth.upper2,col="#6E2884")
abline(v=depth.upper3,col="#FF5700")
text(depth.upper+30,800,paste("Avg+1SD =",round(depth.upper, digits = 2)), col = "#009AEB")
text(depth.upper2+30,600, paste("Avg+2SD =",round(depth.upper2, digits = 2)), col = "#6E2884")
text(depth.upper3+30,400, paste("Avg+3SD =",round(depth.upper3, digits = 2)), col = "#FF5700")

#Average depth plus 3SD: 
print(paste("Average depth plus 3SD:", depth.upper3))

save.image(file = "sc01_pt4_mean_depth.RData")
