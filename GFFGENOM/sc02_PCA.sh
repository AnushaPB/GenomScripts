#!/bin/bash                                         
#SBATCH -p general                                           
#SBATCH --mem=100g
#SBATCH -t 24:00:00                                      
#SBATCH -o /home/apb56/scratch60/stdout/sc02_PCA.sh.%J.out
#SBATCH -e /home/apb56/scratch60/stderr/sc02_PCA.sh.%J.err    
#SBATCH --mail-type=ALL                                  
#SBATCH --mail-user=anusha.bishop@yale.edu                                
#SBATCH --job-name=sc02_PCA.sh   

NAME=BCFtools_GxE_minQ90_missing_mac3_autosomes_meanDP_AB
#make bed file
plink --vcf ${NAME}.recode.vcf --double-id --allow-extra-chr --allow-no-sex --make-bed --out ${NAME}
#run PCA
plink --bfile ${NAME} --bp-space 50000 --allow-extra-chr --allow-no-sex --pca --out ${NAME}_thin50kb 
# This outputs .eigenval and .eigenvec files
