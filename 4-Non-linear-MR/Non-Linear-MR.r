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
library(nlmr)
library(Hmisc)

setwd("/home/tianshanshan/results")
i <- "/home/tianshanshan/data/Demo_cancer_samples_total_mortality_analysis_sleep_duration.csv"
data <- read_csv(i)
data$Employment_status <- factor(data$Employment_status, levels = c(1,2,3,4), labels = c("Employed","Retired","shift_work","Night_shift_work"))
data$Mental_health_issues <- factor(data$Mental_health_issues, levels = c(0,1), labels = c("No","Yes"))
data$Smoking_status <- factor(data$Smoking_status, levels = c(0,1,2), labels = c("Never","Previous","Current"))
data$Alcohol_drinker_status <- factor(data$Alcohol_drinker_status, levels = c(0,1,2), labels = c("Never","Previous","Current"))
data$Sex <- factor(data$Sex, levels = c(0,1), labels = c("female","male"))
#data$Insomnia <- factor(data$Insomnia, levels = c(1,2,3), labels = c("Never","Sometimes","Usually"))
#data$Chronotype <- factor(data$Chronotype, levels = c(1,2), labels = c("Early_preference","Evening_preference"))
data$Assessment_centres <- as.factor(data$Assessment_centres)
y <- data$Status
x <- data$Sleep_duration
g <- data$GRS_score

#basic
covar_basic <- as.data.frame(data[,c(2:4,11:20)])
plm_basic = piecewise_mr(y, x, g, covar_basic, family = "gaussian", q = 3, nboot = 50, ci_quantiles = 3, fig = TRUE)
summary(plm_basic)
print(summary(plm_basic))
#full
covar_full <- as.data.frame(data[,c(2:20)])
plm_full = piecewise_mr(y, x, g, covar_full, family = "gaussian", q = 3, nboot = 50, ci_quantiles = 3, fig = TRUE)
summary(plm_full)
print(summary(plm_full))
