#!/bin/bash                                         
#SBATCH -p general                                           
#SBATCH --mem=100g
#SBATCH -t 24:00:00                                      
#SBATCH -o /home/apb56/scratch60/stdout/sc01_pt2_mac.sh.%J.out
#SBATCH -e /home/apb56/scratch60/stderr/sc01_pt2_mac.sh.%J.err                                      
#SBATCH --mail-type=ALL                                  
#SBATCH --mail-user=anusha.bishop@yale.edu                                
#SBATCH --job-name=sc01_pt2_mac.sh    

#load appropriate modules 
module load PLINK
module load VCFtools

cd /home/apb56/project/VCFFILTER

NAME=BCFtools_GxE_minQ90_missing

vcftools --vcf ${NAME}.recode.vcf \
--max-alleles 2 --min-alleles 2 --mac 3 --recode --out ${NAME}_mac3

