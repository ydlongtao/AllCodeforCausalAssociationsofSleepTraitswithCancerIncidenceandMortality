#!/usr/bin/Rscript

library(data.table)
library(tidyverse)
setwd("/home/tianshanshan/results")
#---Load in data---####

#Read in csv file
data <- fread("/home/tianshanshan/data/ukb48344.csv", header = T)
#---Select relevant columns---####

export <- data %>%select(eid, 
  starts_with ("31"), #sex
  starts_with("40005"), #Date of cancer diagnosis
  starts_with("40008"), #Age at cancer diagnosis
  starts_with("22027"), #Outliers for heterozygosity or missing rate
  starts_with("22001"), #Genetic sex
  starts_with("22019"), #Sex chromosome aneuploidy
  starts_with("22021"), #Genetic kinship to other participants
  starts_with("54"), #UK Biobank assessment centre
  starts_with("53"), #Date of attending assessment centre
  starts_with("84"), #Cancer year/age first occurred
  starts_with("191"), #Date lost to follow-up
  starts_with("189"), #Townsend deprivation index at recruitment
  starts_with("826"), #Job involves shift work
  starts_with("2100"), #Seen a psychiatrist for nerves, anxiety, tension or depression
  starts_with("21001"), #Body mass index (BMI)
  starts_with("20116"), #Smoking status
  starts_with("6142"), #Current employment status
  starts_with("3426"), #Job involves night shift work
  starts_with("22009"), #Genetic principal components
  starts_with("21022"), #Age at recruitment	
  starts_with("20117"), #Alcohol drinker status
  starts_with("40006"), #Type of cancer: ICD10
  starts_with("1160"), #Sleep duration
  starts_with("1180"), #Morning/evening person (chronotype)
  starts_with("1200"), #Sleeplessness / insomnia
  starts_with("40023"), #Records in death dataset
  starts_with("40000"), #Date of death
  starts_with("40001"), #Underlying (primary) cause of death: ICD10
  starts_with("40002"), #Contributory (secondary) causes of death: ICD10
  starts_with("40010"), #Description of cause of death

#Save as R data file for analysis
saveRDS(export, "icd10_ukb_extracted.rds")
write_csv(export,"icd10_ukb_extracted.csv", na = "")
