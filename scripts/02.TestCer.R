
library(openxlsx)
library(ggplot2)
library(tidyverse)
dat.gr <- read.xlsx('data/Cercis.xlsx')

dat.gr.summary <- 
    table(dat.gr$CalcFullName) |> 
    sort(decreasing = T)
write.csv(dat.gr.summary, 'out/dat.gr.summary.csv')

dat.cer_am <- read.xlsx('data/Cercis.xlsx')
dat.cer_am <- dat.cer_am[!is.na(dat.cer_am$SpecimenAccession),]
row.names(dat.cer_am) <- dat.cer_am$SpecimenAccession
for(i in c("Buds", "Flowers", "Fruits", "Percent.Buds", "Percent.Flowers", 
"Percent.Fruit")) {
    class(dat.cer_am[[i]]) <- "numeric"
}

dat.cer_am$DayOfYear <- as.integer(
    format(
        as.Date(
            sprintf("2025-%02d-%02d",
                    as.numeric(dat.cer_am$Month),
                    as.numeric(dat.cer_am$Day))
        ),
        "%j"
    )
)
dat.cer.per <- dat.cer_am %>%
  pivot_longer(
    cols = c(Percent.Buds, Percent.Flowers, Percent.Fruit),
    names_to = "Phenophase",
    values_to = "Percent"
  )
view(dat.cer.per)
dat.cer.per2 <- 
    dat.cer.per %>%
    filter(Percent != 0)

    
p <- ggplot( dat.cer.per2, aes(x = DayOfYear, y = Percent, color = Phenophase)) +
  geom_point() + geom_smooth(method = "lm") + scale_color_manual(values = c("Percent.Buds" = "purple", "Percent.Flowers" = "blue", "Percent.Fruit" = "yellow")) + labs( x = "Day of Year", y = "Percent", color = "Phenophase")
quartz()
print(p)
ggsave('out/DOYaPlot.pdf')




