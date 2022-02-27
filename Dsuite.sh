#Dsuite使用前更改clib库
export LD_LIBRARY_PATH=/users/huxp/biosoft/gcc-4.9.4/lib64:$LD_LIBRARY_PATH

#使用bi-allic
vcftools --vcf combine.150.PT.snps.depth.recode.vcf --max-alleles 2 --min-alleles 2 --out combine.150.PT.biallelic --recode --recode-INFO-all

#Dsuite
Dsuite Dtrios combine.150.PT.biallelic.recode.vcf pop.file -t tree.nwk

#fbranch
Dsuite Fbranch TREE_FILE.nwk FVALS_tree.txt > fbranch.txt

#fbranch plot
python ~/biosoft/Dsuite/utils/dtools.py ./fbranch.txt ./tree.nwk