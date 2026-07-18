
library(lme4)
library(lubridate)
library(emmeans)


field = read.xlsx('data/dat.field.pheno2.xlsx')

field$Direction <- factor(field$Direction)
field$Shade <- factor(field$Shade)
field$PlantNumber <- factor(field$PlantNumber)

field$Mean_DOY <- as.Date(field$Mean_DOY)
field$Mean_DOY <- yday(field$Mean_DOY)

lmerTests_Field <- list(
early = lm(Mean_DOY ~ Direction * Shade, data= filter(field, Phenophase == "early")),
peak = lm(Mean_DOY ~ Direction * Shade, data= filter(field, Phenophase == "peak")),
late = lm(Mean_DOY ~ Direction * Shade, data= filter(field, Phenophase == "late"))
)

lapply(lmerTests_Field, summary)
lapply(lmerTests_Field, anova)


# No noticable variation in doy between plants
# South differs significantly from East
# Shade level 1 is significantly different to no shade but shade level 2 isn't
# The effect of shade depends on direction specifically the combo of south and shade 2
lmerfield <- lmer(Mean_DOY ~ Direction * Shade + (1 | PlantNumber), data= field)

summary(lmerfield)
emmeans(lmerfield, ~ Direction * Shade)
pairs(emmeans(lmerfield, ~ Direction | Shade))
