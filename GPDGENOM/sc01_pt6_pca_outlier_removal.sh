#!/bin/bash                                         
#SBATCH -p general                                           
#SBATCH --mem=100g
#SBATCH -t 24:00:00                                      
#SBATCH -o /home/apb56/scratch60/stdout/sc01_pt6_pca_outlier_removal.sh.%J.out
#SBATCH -e /home/apb56/scratch60/stderr/sc01_pt6_pca_outlier_removal.sh.%J.err    
#SBATCH --mail-type=ALL                                  
#SBATCH --mail-user=anusha.bishop@yale.edu                                
#SBATCH --job-name=sc01_pt6_pca_outlier_removal.sh   

#load appropriate modules 
module load PLINK
module load VCFtools

cd /home/apb56/project/VCFFILTER

NAME=BCFtools_GxE_minQ90_missing_mac3_autosomes_meanDP_AB
#make bed file
plink --vcf ${NAME}.recode.vcf --double-id --allow-extra-chr --allow-no-sex --make-bed --out ${NAME}
#run PCA
plink --bfile ${NAME} --bp-space 50000 --mind .5 --allow-extra-chr --allow-no-sex --pca --out ${NAME}_thin50kb_mind50
# This outputs .eigenval and .eigenvec files

#removal of outlier based on PCA
vcftools --vcf ${NAME}.recode.vcf --remove-indv DUK_14_518 --recode --out ${NAME}_pcrm
