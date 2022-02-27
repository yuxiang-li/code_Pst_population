#LD过滤后的vcf文件转化位ped格式
plink --vcf combine.150.PT.snps.LD.pruned.vcf --recode --out combine.PT.treemix --allow-extra-chr --chr-set 94 no-xy no-mt

#赋予snp名字
awk '{print $1"\t"$1"_"$4"\t"$3"\t"$4}' combine.PT.treemix.map > combine.PT.treemix.pos.map
mv combine.PT.treemix.ped combine.PT.treemix.pos.ped

#ped转bed
plink --file combine.PT.treemix.pos --make-bed --out combine.PT.treemix.pos --allow-extra-chr --chr-set 94 no-xy no-mt

#将得到的fam文件更改
eg
fid iid 
GS GS_05 0 0 0 -9
GS GS_06 0 0 0 -9
GS GS_07 0 0 0 -9
GS GS_08 0 0 0 -9
GS GS_09 0 0 0 -9
GS GS_10 0 0 0 -9
GZ GZ_01 0 0 0 -9
GZ GZ_04 0 0 0 -9
GZ GZ_07 0 0 0 -9
GZ GZ_09 0 0 0 -9
GZ GZ_10 0 0 0 -9
GZ GZ_11 0 0 0 -9
GZ GZ_12 0 0 0 -9

#准备pop文件
eg
fid	iid	group
GS	GS_05	1-1
GS	GS_06	1-1
GS	GS_07	1-1
GS	GS_08	1-1
GS	GS_09	1-1
GS	GS_10	1-1
GZ	GZ_01	2-1
GZ	GZ_04	1-3
GZ	GZ_07	2-1
GZ	GZ_09	2-1
GZ	GZ_10	1-3
GZ	GZ_11	1-3
GZ	GZ_12	1-3

#根据group计算等位基因频率
plink --bfile combine.PT.treemix.pos --freq --missing --within pop.txt --out PST --allow-extra-chr --chr-set 94 no-xy no-mt

#转化为treemix格式
gzip PST.frq.strat
python2 ~/biosoft/plink2treemix.py PST.frq.strat.gz PST.treemix.frq.gz


#sh脚本treemix m为1-7 每个重复20次
for m in {1..7}
 do
 for i in {1..20}
  do
  /users/huxp/biosoft/miniconda3/envs/treemix/bin/treemix -se -bootstrap \
  -i /users/huxp/jichen.dai/workdir/treemix/2021.10.15/treemix/data/PST.treemix.frq.gz \
  -o PST.treemix.${i}.${m} \ #此处命名OptM识别
  -m ${m} \
  -k 500 \
  -root Outgroup \
  -noss
  done
done

#OptM R包检验最优的m值
library(OptM)
linear = optM("./output")
plot_optM(linear)
dev.off()

#绘图
source("plotting_funcs.R") #treemix scr文件夹中R脚本
plot_tree("TreeMix") #TreeMix为结果文件前缀
dev.off()

