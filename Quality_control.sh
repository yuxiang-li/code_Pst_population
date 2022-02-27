#quality control（70%~130%）
vcftools --vcf --recode --recode-INFO-all --mac 3 --maf 0.05 --minQ 200 --max-missing 0.3 --min-meanDP 38 --max-meanDP 71 --remove-indels --out