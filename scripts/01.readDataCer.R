
library(openxlsx)
library(ggplot2)
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
