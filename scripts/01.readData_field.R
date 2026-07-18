## TO DO
### Read and format field data
### make a decision about 4-sides of field data... probably this 
###   will go into a separate data frame just for Tilia americana
###   Plan: separate out til am data and add in field data for a subset of analyses

library(openxlsx)
library(dplyr)
library(ggplot2)
dat.field = read.xlsx('data/Field_Data.xlsx')


### cleanup
for(i in c("Percent.Buds", "Percent.Flowers", "Percent.Fruit")) {
    class(dat.field[[i]]) <- "numeric"
    dat.field[[i]] <- dat.field[[i]] * 100
}

write.csv(dat.field, 'out/excluded_field.csv')


dat.field$doy <- yday(as.Date(dat.field$Date, origin = "1899-12-30"))

write.csv(dat.field, 'out/dat.field.cleaned.csv')
rm(i)

#Bar chart phenophases per tree
dat.field |>
filter(!is.na(Phenophase)) |>
ggplot(aes(x = factor(Phenophase), fill = PlantNumber)) + geom_bar()

#Adding avg doy for early, peak, late per tree and direction
pheno_summary <- dat.field |>
  filter(!is.na(doy), !is.na(Direction), !is.na(PlantNumber), !is.na(Phenophase)) |>
  
  mutate(Pheno_Stage = case_when(
    Phenophase %in% 1:3 ~ "early",
    Phenophase %in% 4:6 ~ "peak",
    Phenophase %in% 7:8 ~ "late",
    TRUE ~ NA_character_ 
  )) |>
  
filter(!is.na(Pheno_Stage)) |>
group_by(PlantNumber, Direction, Pheno_Stage) |>
  summarise(
    Mean_DOY = mean(doy, na.rm = TRUE),
    Observation_Count = n(),
    .groups = "drop")

write.csv(pheno_summary, 'out/dat.field.pheno.csv')
