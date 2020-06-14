#!/bin/bash                                         
#SBATCH -p general                                           
#SBATCH --mem=100g
#SBATCH -t 24:00:00                                      
#SBATCH -o /home/apb56/scratch60/stdout/sc01_pt3_split_chromosomes.sh.%J.out
#SBATCH -e /home/apb56/scratch60/stderr/sc01_pt3_split_chromosomes.sh.%J.err     
#SBATCH --mail-type=ALL                                  
#SBATCH --mail-user=anusha.bishop@yale.edu                                
#SBATCH --job-name=sc01_pt3_split_chromosomes.sh    

#load appropriate modules 
module load PLINK
module load VCFtools

#cd /home/apb56/project/VCF
#OUTDIR = /home/apb56/project/VCFFILTER
#make the bed files that map scaffold to autosome/X/other 
#cat meA.bed meD.bed meF.bed > $OUTDIR/X.bed
#cat meB.bed meC.bed meE.bed > $OUTDIR/autosomes.bed
#cat meA.bed meB.bed meC.bed meD.bed meE.bed meF.bed > $OUTDIR/all_mes.bed

cd /home/apb56/project/VCFFILTER
NAME=BCFtools_GxE_minQ90_missing_mac3
vcftools --vcf ${NAME}.recode.vcf --bed autosomes.bed --recode --out ${NAME}_autosomes
vcftools --vcf ${NAME}.recode.vcf --bed X.bed --recode --out ${NAME}_X
vcftools --vcf ${NAME}.recode.vcf --exclude-bed all_mes.bed --recode --out ${NAME}_other
