#!/usr/bin/Rscript
library(survminer)
library(survival)
library(plyr)
library(xlsx)
library(eoffice)
library(tidyverse)
library(RadialMR)
library(TwoSampleMR)
library(MRPRESSO)
library(MRAPSS)
library(MendelianRandomization)

setwd("/home/tianshanshan/results")
exposure <- read_csv("Demo_total_mortality_short_outlier_MR_QC_input_exposure.csv")
outcome <- read_csv("Demo_total_mortality_short_outlier_MR_QC_input_outcome.csv")
harmonise<- harmonise_data(exposure, outcome, action = 2)
res <- mr(harmonise)
res
mr_scatter_plot(res,harmonise)
mr_plot(mr_allmethods(mr_input, method="all", iterations = 50))
ivw.object <- ivw_radial(r_input = harmonise, alpha = 0.05,weights = 1, tol = 0.0001, summary = TRUE)
egg.object <- egger_radial(r_input = harmonise, alpha = 0.05,
             weights = 1, summary = TRUE)
r_object <- c(ivw.object, egg.object)
plot_radial(r_object)

het <- mr_heterogeneity(harmonise)
het

pleio <- mr_pleiotropy_test(harmonise)
pleio

single <- mr_leaveoneout(harmonise)
mr_leaveoneout_plot(single)