#!/bin/bash                                         
#SBATCH -p general                                           
#SBATCH --mem=100g
#SBATCH -t 24:00:00                                      
#SBATCH -o /home/apb56/scratch60/stdout/sc01_pt4_mean_depth.sh.%J.out
#SBATCH -e /home/apb56/scratch60/stderr/sc01_pt4_mean_depth.sh.%J.err    
#SBATCH --mail-type=ALL                                  
#SBATCH --mail-user=anusha.bishop@yale.edu                                
#SBATCH --job-name=sc01_pt4_mean_depth.sh    

#load appropriate modules 
module load PLINK/1.90-beta6.9
module load VCFtools

cd /home/apb56/project/VCFFILTER

NAME=BCFtools_GxE_minQ90_missing_mac3_autosomes
vcftools --vcf ${NAME}.recode.vcf \
--site-mean-depth --out ${NAME}
#generates .ldepth.mean file

#visualize the data in R, and choose a --max-meanDP to filter by:
#mean depth + 3SD = 68.17

NAME=BCFtools_GxE_minQ90_missing_mac3_autosomes
vcftools --vcf ${NAME}.recode.vcf \
--max-meanDP 68.17 --min-meanDP 10 --recode --out ${NAME}_meanDP
