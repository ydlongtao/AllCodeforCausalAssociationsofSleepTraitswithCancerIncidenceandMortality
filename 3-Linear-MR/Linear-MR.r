#!/usr/bin/Rscript
library(survminer)
library(survival)
library(plyr)
library(xlsx)
library(eoffice)
library(tidyverse)
library(ggplot2)
library(rms) 
library(modelsummary)
setwd("/home/tianshanshan/results")
i <- "/home/tianshanshan/data/Demo_cancer_samples_total_mortality_analysis_evening_chronotype.csv"
data <- read_csv(i)
data$Employment_status <- factor(data$Employment_status, levels = c(1,2,3,4), labels = c("Employed","Retired","shift_work","Night_shift_work"))
data$Mental_health_issues <- factor(data$Mental_health_issues, levels = c(0,1), labels = c("No","Yes"))
data$Smoking_status <- factor(data$Smoking_status, levels = c(0,1,2), labels = c("Never","Previous","Current"))
data$Alcohol_drinker_status <- factor(data$Alcohol_drinker_status, levels = c(0,1,2), labels = c("Never","Previous","Current"))
data$Sex <- factor(data$Sex, levels = c(0,1), labels = c("female","male"))
data$Sleep_duration <- as.factor(data$Sleep_duration)
data$Assessment_centres <- as.factor(data$Assessment_centres)

#basic_model
stage1 <- lm( GRS_score ~ Sleep_duration +Sex + Age_at_cancer_diagnosis + Assessment_centres + Top_one + Top_two + Top_three +Top_four + Top_five +Top_six + Top_seven +Top_eight + Top_nine + Top_ten, data = data)
summary(stage1)

stage2 <- glm(data$Status ~ fitted(stage1) + Sex + Age_at_cancer_diagnosis +Assessment_centres + Top_one + Top_two + Top_three +Top_four + Top_five +Top_six + Top_seven +Top_eight + Top_nine + Top_ten, data = data , family = binomial)
glm2 <- summary(stage2)
OR<-round(exp(coef(stage2)),20)
SE<-glm2$coefficients[,2]
CI5<-round(exp(coef(stage2)-1.96*SE),20)
CI95<-round(exp(coef(stage2)+1.96*SE),20)
CI<-paste0(CI5,'-',CI95)
P<-round(glm2$coefficients[,4],20)
res1<-data.frame(OR,CI,P)[-1,];res1
write.csv(res1 ,paste(str_sub(basename(i),end=-5),"_Liner_MR_Basic_model.csv", sep = ""))


#full_model
stage1 <- lm( GRS_score ~ Sleep_duration +Sex + Age_at_cancer_diagnosis + Assessment_centres + Townsend_deprivation_index + Mental_health_issues + Body_mass_index + Smoking_status + Employment_status + Alcohol_drinker_status + Top_one + Top_two + Top_three +Top_four + Top_five +Top_six + Top_seven +Top_eight + Top_nine + Top_ten, data = data)
summary(stage1)

stage2 <- glm(data$Status ~ fitted(stage1) +Sex + Age_at_cancer_diagnosis + Assessment_centres + Townsend_deprivation_index + Mental_health_issues + Body_mass_index + Smoking_status + Employment_status + Alcohol_drinker_status + Top_one + Top_two + Top_three +Top_four + Top_five +Top_six + Top_seven +Top_eight + Top_nine + Top_ten, data = data , family = binomial)
glm2 <- summary(stage2)
OR<-round(exp(coef(stage2)),20)
SE<-glm2$coefficients[,2]
CI5<-round(exp(coef(stage2)-1.96*SE),20)
CI95<-round(exp(coef(stage2)+1.96*SE),20)
CI<-paste0(CI5,'-',CI95)
P<-round(glm2$coefficients[,4],20)
res1<-data.frame(OR,CI,P)[-1,];res1
write.csv(res1 ,paste(str_sub(basename(i),end=-5),"_Liner_MR_Full_model.csv", sep = ""))
