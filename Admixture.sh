for k in {1,2,3,4,5,6,7,8,9};
do
/users/huxp/biosoft/miniconda3/envs/daijc-py37/bin/admixture --cv=10 /users/huxp/jichen.dai/workdir/vcf_purned/LD0.2-50-1/PST_purned.bed $k | tee /users/huxp/jichen.dai/workdir/admixture/second/log${k}.out;
done 