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
i <- "/home/tianshanshan/data/Demo_cancer_samples_total_mortality_analysis.csv"
data <- read_csv(i)
#data <- data[complete.cases(data),]
Baseline <- data
BaSurv <- Surv(time=Baseline$Follow_up_years,event=Baseline$Status)
Baseline$BaSurv <- with(Baseline,BaSurv) 
Baseline$Insomnia <- as.factor(Baseline$Insomnia)
Baseline$Chronotype <- as.factor(Baseline$Chronotype)
Baseline$Sleep_duration <- as.factor(Baseline$Sleep_duration)


#Chronotype
fit <- survfit(Surv(Follow_up_years,Status)~Chronotype,data = Baseline )
#pval <- surv_pvalue(fit, data = Baseline, method = "survdiff", get_coord = TRUE)

pdf(file= paste(str_sub(basename(i),end=-5),"_KM_Chronotype.pdf", sep = ""), onefile = FALSE,
width = 10, 
height = 10,
)
p1 <- ggsurvplot(fit, data = Baseline,
surv.median.line = "hv", 
title="Kaplan-Meier Curve for OS ", 
legend.title = colnames(Baseline)[2],legend.labs = c("Definite morning","More morning","More evening","Definite evening"), 
pval = T,
pval.size =8, 
conf.int = TRUE,
conf.int.alpha =0.2,
risk.table = TRUE, 
tables.height = 0.2, 
palette = "lancet",
ggtheme = theme_bw(), 
font.main = c(16, "bold", "darkblue"),font.x = c(14, "bold.italic", "red"),font.y = c(14, "bold.italic", "darkred"),font.tickslab = c(12, "plain", "darkgreen"), font.legend = 14,
ylim = c(0.6, 1),
xlim = c(0,5),
axes.offset=FALSE, 
break.x.by=1,
break.y.by=0.2,
surv.scale="percent",
ncensor.plot = FALSE
) 

print(p1)
dev.off()


pdf(file= paste(str_sub(basename(i),end=-5),"_CV_Chronotype.pdf", sep = ""), onefile = FALSE,
width = 10, 
height = 10, 
)
p1 <- ggsurvplot(fit, fun = "cumhaz",
palette = "lancet",
ggtheme = theme_bw(), 
font.main = c(16, "bold", "darkblue"),font.x = c(14, "bold.italic", "red"),font.y = c(14, "bold.italic", "darkred"),font.tickslab = c(12, "plain", "darkgreen"), font.legend = 14,# 改变字体大小类型颜色等
ylim = c(0, 0.5),
xlim = c(0,5),
axes.offset=FALSE, 
break.x.by=1,
break.y.by=0.2,
title="Kaplan-Meier Curve for OS ", 
legend.title = colnames(Baseline)[2],legend.labs = c("Definite morning","More morning","More evening","Definite evening"), #改变图例
conf.int = TRUE, 
conf.int.alpha =0.2,
risk.table = TRUE, 
pval = T,
pval.coord = c(0.4, 0.1),
pval.size =8, 
) 

print(p1)
dev.off()
	   
		   
#Insomnia
fit <- survfit(Surv(Follow_up_years,Status)~Insomnia,data = Baseline )
#pval <- surv_pvalue(fit, data = Baseline, method = "survdiff", get_coord = TRUE)
pdf(file= paste(str_sub(basename(i),end=-5),"_KM_Insomnia.pdf", sep = ""), onefile = FALSE,
width = 10, 
height = 10, 
)
p1<- ggsurvplot(fit, data = Baseline,
surv.median.line = "hv", 
title="Kaplan-Meier Curve for OS ", 
legend.title = colnames(Baseline)[4],legend.labs = c("Never","Sometimes","Usually"), 
pval = T,
pval.coord = c(0.4, 0.65),
pval.size =8, 
conf.int = TRUE, 
conf.int.alpha =0.2,
risk.table = TRUE, 
tables.height = 0.2, 
palette = "lancet",
ggtheme = theme_bw(), 
font.main = c(16, "bold", "darkblue"),font.x = c(14, "bold.italic", "red"),font.y = c(14, "bold.italic", "darkred"),font.tickslab = c(12, "plain", "darkgreen"), font.legend = 14,# 改变字体大小类型颜色等
ylim = c(0.6, 1),
xlim = c(0,5),
axes.offset=FALSE, 
break.x.by=1,
break.y.by=0.2,
surv.scale="percent",
ncensor.plot = FALSE
) 

print(p1)
dev.off()

pdf(file= paste(str_sub(basename(i),end=-5),"_CV_Insomnia.pdf", sep = ""), onefile = FALSE,
width = 10, 
height = 10, 
)
p1 <- ggsurvplot(fit, fun = "cumhaz",
palette = "lancet",
ggtheme = theme_bw(), 
font.main = c(16, "bold", "darkblue"),font.x = c(14, "bold.italic", "red"),font.y = c(14, "bold.italic", "darkred"),font.tickslab = c(12, "plain", "darkgreen"), font.legend = 14,# 改变字体大小类型颜色等
ylim = c(0, 0.5),
xlim = c(0,5),
axes.offset=FALSE, 
break.x.by=1,
break.y.by=0.2,
title="Kaplan-Meier Curve for OS ", 
legend.title = colnames(Baseline)[4],legend.labs = c("Never","Sometimes","Usually"), 
conf.int = TRUE, 
conf.int.alpha =0.2,
risk.table = TRUE, 
pval = T,
pval.coord = c(0.4, 0.1),
pval.size =8, 
) 

print(p1)
dev.off()

#Sleep_duration
fit <- survfit(Surv(Follow_up_years,Status)~Sleep_duration,data = Baseline )

pdf(file= paste(str_sub(basename(i),end=-5),"_KM_Sleep_duration.pdf", sep = ""), onefile = FALSE,
width = 10, 
height = 10, 
)
p1 <- ggsurvplot(fit, data = Baseline,
surv.median.line = "hv", 
title="Kaplan-Meier Curve for OS ", 
legend.title = colnames(Baseline)[3],legend.labs = c("Normal 6-8h","Extreme short ≤4h","Shorter about5h","Longer about9h","Extreme long ≥10h"), 
pval = T,
pval.coord = c(0.4, 0.65),
pval.size =8, 
conf.int = TRUE, 
conf.int.alpha =0.2,
risk.table = TRUE, 
tables.height = 0.2, 
palette = "lancet",
ggtheme = theme_bw(), 
font.main = c(16, "bold", "darkblue"),font.x = c(14, "bold.italic", "red"),font.y = c(14, "bold.italic", "darkred"),font.tickslab = c(12, "plain", "darkgreen"), font.legend = 14,
ylim = c(0.6, 1),
xlim = c(0,5),
axes.offset=FALSE, 
break.x.by=1,
break.y.by=0.2,
surv.scale="percent",
ncensor.plot = FALSE
) 

print(p1)
dev.off()


pdf(file= paste(str_sub(basename(i),end=-5),"_CV_Sleep_duration.pdf", sep = ""), onefile = FALSE,
width = 10, 
height = 10, 
)
p1 <- ggsurvplot(fit, fun = "cumhaz",
palette = "lancet",
ggtheme = theme_bw(), 
font.main = c(16, "bold", "darkblue"),font.x = c(14, "bold.italic", "red"),font.y = c(14, "bold.italic", "darkred"),font.tickslab = c(12, "plain", "darkgreen"), font.legend = 14,
ylim = c(0, 0.5),
xlim = c(0,5),
axes.offset=FALSE,
break.x.by=1,
break.y.by=0.2,
title="Kaplan-Meier Curve for OS ", 
legend.title = colnames(Baseline)[3],legend.labs = c("Normal 6-8h","Extreme short ≤4h","Shorter about5h","Longer about9h","Extreme long ≥10h"), 
conf.int = TRUE, 
conf.int.alpha =0.2,
risk.table = TRUE, 
pval = T,
pval.coord = c(0.4, 0.1),
pval.size =8, 
) 

print(p1)
dev.off()

}
