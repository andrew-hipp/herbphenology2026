
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

##old results before I played around
# No noticable variation in doy between plants
# South differs significantly from East
# Shade level 1 is significantly different to no shade but shade level 2 isn't
# The effect of shade depends on direction specifically the combo of south and shade 2
lmerfield <- lmer(Mean_DOY ~ Direction * Shade + (1 | PlantNumber), data= field)

summary(lmerfield)
emmeans(lmerfield, ~ Direction * Shade)
pairs(emmeans(lmerfield, ~ Direction | Shade))

#Comparing the trees to each other
lmer_trees <- list(
early = lm(Mean_DOY ~ PlantNumber, data= filter(field, Phenophase == "early")),
peak = lm(Mean_DOY ~ PlantNumber, data= filter(field, Phenophase == "peak")),
late = lm(Mean_DOY ~ PlantNumber, data= filter(field, Phenophase == "late")))
lapply(lmer_trees, summary)

pairwise_results <- lapply(lmer_trees, function(model) {means <- emmeans(model, ~ PlantNumber)
pairs(means)})

pairwise_results$early
pairwise_results$peak
pairwise_results$late


#
individual <- read.xlsx('data/Field_daily.xlsx')

individual_clean <- individual |>
  mutate(
    pheno_stage = case_when(
      `Avg.Phenophase` %in% 1:3 ~ "early",
      `Avg.Phenophase` %in% 4:6 ~ "peak",
      `Avg.Phenophase` %in% 7:8 ~ "late",
      TRUE ~ NA_character_ )) |>
  filter(!is.na(pheno_stage)) |>
  mutate(
    PlantNumber = factor(PlantNumber),
    Mean_DOY = yday(as.Date(Mean_DOY)))

#Comparing each tree to the global avg instead of one tree
global_avg_model <- lm(Mean_DOY ~ PlantNumber + pheno_stage, data = individual_clean, contrasts = list(PlantNumber = "contr.sum"))
summary(global_avg_model)
