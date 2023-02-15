#!/usr/bin/Rscript
library(survminer)
library(survival)
library(plyr)
library(xlsx)
library(eoffice)
library(tidyverse)
setwd("/home/tianshanshan/results")
i <- "/home/tianshanshan/data/Demo_cancer_patients_total_mortality_analysis.csv"
data <- read_csv(i)
Baseline = data
BaSurv <- Surv(time=Baseline$Follow_up_years,event=Baseline$Status)
Baseline$BaSurv <- with(Baseline,BaSurv)  
Baseline$Employment_status <- factor(Baseline$Employment_status, levels = c(1,2,3,4), labels = c("Employed","Retired","shift_work","Night_shift_work"))
Baseline$Mental_health_issues <- factor(Baseline$Mental_health_issues, levels = c(0,1), labels = c("No","Yes"))
Baseline$Smoking_status <- factor(Baseline$Smoking_status, levels = c(0,1,2), labels = c("Never","Previous","Current"))
Baseline$Alcohol_drinker_status <- factor(Baseline$Alcohol_drinker_status, levels = c(0,1,2), labels = c("Never","Previous","Current"))
Baseline$Sex <- factor(Baseline$Sex, levels = c(0,1), labels = c("female","male"))
Baseline$Insomnia <- as.factor(Baseline$Insomnia)
Baseline$Chronotype <- as.factor(Baseline$Chronotype)
Baseline$Sleep_duration <- as.factor(Baseline$Sleep_duration)
Baseline$Assessment_centres <- as.factor(Baseline$Assessment_centres)

#Fully adjusted model
fml_full=as.formula(paste0("BaSurv~",paste0(colnames(Baseline)[c(2:20)],collapse = "+")))
full_Cox <- coxph(fml_full,data=Baseline)
MultiSum <- summary(full_Cox)
MultiSum$coefficients
MultiSum$conf.int
MHR <- round(MultiSum$coefficients[,2],2)
MPValue <- round(MultiSum$coefficients[,5],3)
MCIL <- round(MultiSum$conf.int[,3],2)
MCIH <- round(MultiSum$conf.int[,4],2)
MCI <- paste0(MCIL,'-',MCIH)
Multicox <- data.frame(
"Hazard ratio" = MHR,
"CI95" = MCI,
"p-Value" = MPValue)
write.csv(Multicox ,paste(str_sub(basename(i),end=-5),"_Fully_adjusted_model.csv", sep = ""))
pdf(file= paste(str_sub(basename(i),end=-5),"_Fully_adjusted_model.pdf", sep = ""), onefile = FALSE,
width = 20, 
height = 20, 
)
p1 <- ggforest(full_Cox, data = Baseline,
main = "Hazard ratio",   
cpositions = c(0.10, 0.22, 0.4),
fontsize = 1.0,
refLabel = "1", 
noDigits = 4  
)
print(p1)
dev.off()

#Additional adjusted model
fml_additional=as.formula(paste0("BaSurv~",paste0(colnames(Baseline)[c(2:23)],collapse = "+")))
additional_Cox <- coxph(fml_additional,data=Baseline)
MultiSum <- summary(additional_Cox)
MultiSum$coefficients
MultiSum$conf.int
MHR <- round(MultiSum$coefficients[,2],2)
MPValue <- round(MultiSum$coefficients[,5],3)
MCIL <- round(MultiSum$conf.int[,3],2)
MCIH <- round(MultiSum$conf.int[,4],2)
MCI <- paste0(MCIL,'-',MCIH)
Multicox <- data.frame(
"Hazard ratio" = MHR,
"CI95" = MCI,
"p-Value" = MPValue)
write.csv(Multicox ,paste(str_sub(basename(i),end=-5),"_additional_adjusted_model.csv", sep = ""))
pdf(file= paste(str_sub(basename(i),end=-5),"_additional_adjusted_model.pdf", sep = ""), onefile = FALSE,
width = 20, 
height = 20, 
)
p2 <- ggforest(additional_Cox, data = Baseline,
main = "Hazard ratio",  
cpositions = c(0.10, 0.22, 0.4), 
fontsize = 1.0,
refLabel = "1", 
noDigits = 4  
)
print(p2)
dev.off()