
library(openxlsx)
library(ggplot2)
library(tidyverse)
dat.gr <- read.xlsx('data/Cercis.xlsx')

dat.gr.summary <- 
    table(dat.gr$CalcFullName) |> 
    sort(decreasing = T)
write.csv(dat.gr.summary, 'out/dat.gr.summary.csv')

dat.cer <- read.xlsx('data/Cercis.xlsx')
dat.cer <- dat.cer[!is.na(dat.cer$SpecimenAccession),]
row.names(dat.cer) <- dat.cer$SpecimenAccession
for(i in c("Buds", "Flowers", "Fruits", "Percent.Buds", "Percent.Flowers", 
"Percent.Fruit")) {
    class(dat.cer[[i]]) <- "numeric"
}

dat.cer$DayOfYear <- as.integer(
    format(
        as.Date(
            sprintf("2025-%02d-%02d",
                    as.numeric(dat.cer$Month),
                    as.numeric(dat.cer$Day))
        ),
        "%j"
    )
)
dat.cer.per <- dat.cer %>%
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




