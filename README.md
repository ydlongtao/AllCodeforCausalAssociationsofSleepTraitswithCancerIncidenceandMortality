# All Code Involved in Causal Associations of Sleep Traits with Cancer Incidence and Mortality
This repository accompanies the paper:
Shanshan Tian, Longtao Huangfu, et al. Causal Associations of Sleep Traits with Cancer Incidence and Mortality, Nature Communications, Pre-review, 2023.

## Environment details
All data analysis processes are based on the Linux system Ubuntu 22.04 LTS (GNU/Linux 5.15.0-58-generic x86_64) environment. We created an independent analysis environment through the miniconda3 program. R v4.1.3, Python v3.7.12, and Java openjdk v1.8.0_352 were mainly used. The deployment file has been uploaded.

To create a new analysis environment,Please use
```
conda env create -f environment.yml
```

The code uses some environment variables that need to be set in your linux environment.I set the results, project data and packages directories temporarily with:
```
export RES_DIR="${HOME}/results"
export PROJECT_DATA="${HOME}/data"
export PACKAGE="${HOME}/packages"
```

## Data download 
All individual participant data is processed using the UK Biobank download tools, Detial can be found in here
Data showcase to find out about data items that are available: https://biobank.ndph.ox.ac.uk/ukb/index.cgi 
How to download UKB data: https://biobank.ctsu.ox.ac.uk/crystal/exinfo.cgi?src=AccessingData 
How to download genetic data (also linked in the guide above): 
using ukbgene (older) - https://biobank.ndph.ox.ac.uk/showcase/refer.cgi?id=664 
using gfetch (newer version of download client) - https://biobank.ctsu.ox.ac.uk/showcase/refer.cgi?id=668

Convert dataset from .enc_ukb format to a workable format for R.
```
$PACKAGE/ukbconv $PROJECT_DATA/ukb48344.enc_ukb csv
```

SNP data download. Ensure the key is downloaded in the file and saved as .ukbkey
```
for i in {1..22}; do $PACKAGE/ukbgene imp -c$i; done  

for i in {1..22}; do $PACKAGE/ukbgene imp -m -c$i; done

$PACKAGE/ukbgene imp -cX
$PACKAGE/ukbgene imp -cXY

$PACKAGE/ukbgene imp -m -cX
$PACKAGE/ukbgene imp -m -cXY
```

```
for i in {1..21}; do $PACKAGE/plink2 --bgen $PACKAGE/ukb22828_c${i}_b0_v3.bgen --sample $PACKAGE/ukb22828_c${i}_b0_v3_s487202.sample --make-bed -out $PROJECT_DATA/ukbchr${i} --maf 0.01 --geno 0.05 --threads 20 --hwe 0.000001 --mind 0.05; done
```


## Data preparing
I run this R script to just save relevant variables. This outputs .rds & .csv format files.
```
Rscript $PACKAGE/data-prepare.R
```
We modify the header of the data table by referring to eTable 1 and the samples with all null values are excluded.

## Cox analysis
Please use the example data provided in the Demo folder. 

```
Rscript $PACKAGE/cox-analysis.r
```
This outputs .csv & .pdf format files.

## Linear MR analysis

