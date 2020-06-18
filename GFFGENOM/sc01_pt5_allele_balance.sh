#!/bin/bash                                         
#SBATCH -p general                                           
#SBATCH --mem=100g
#SBATCH -t 24:00:00                                      
#SBATCH -o /home/apb56/scratch60/stdout/sc01_pt5_allele_balance.sh.%J.out
#SBATCH -e /home/apb56/scratch60/stderr/sc01_pt5_allele_balance.sh.%J.err    
#SBATCH --mail-type=ALL                                  
#SBATCH --mail-user=anusha.bishop@yale.edu                                
#SBATCH --job-name=sc01_pt5_allele_balance.sh    

#load appropriate modules 
module load PLINK/1.90-beta6.9
module load VCFtools

cd /home/apb56/project/VCFFILTER

#create the list of snps to exclude
NAME1=BCFtools_GWAS
tail -n +2 ${NAME1}_autosomes_maxDP_AB_exclude.txt | sed 's/scaffold_/scaffold/g' | sed 's/_/\t/g' | sed 's/scaffold/scaffold_/g' > ${NAME1}_autosomes_maxDP_AB_exclude.snps

#perform the vcftools filter
NAME2=BCFtools_GxE_minQ90_missing_mac3_autosomes_meanDP
vcftools --vcf ${NAME2}.recode.vcf --exclude-positions ${NAME1}_autosomes_maxDP_AB_exclude.snps --recode --out ${NAME2}_AB
