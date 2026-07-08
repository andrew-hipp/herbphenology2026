library(openxlsx)
library(ggplot2)
dat.gr <- read.xlsx('data/Herbarium_GREEN_Specimens.xlsx')

dat.gr.summary <- 
    table(dat.gr$CalcFullName) |> 
    sort(decreasing = T)
write.csv(dat.gr.summary, 'out/dat.gr.summary.csv')

dat.til <- read.xlsx('data/Tilia_everything_else.xlsx')
dat.til <- dat.til[!is.na(dat.til$SpecimenAccession),]
row.names(dat.til) <- dat.til$SpecimenAccession
for(i in c("Buds", "Flowers", "Fruits")) {
    class(dat.til[[i]]) <- "numeric"
}

for(i in c("Percent.Buds", "Percent.Flowers", 
"Percent.Fruit")) {
    class(dat.til[[i]]) <- "numeric"
    dat.til[[i]] <- dat.til[[i]] * 100
}

dat.til <- dat.til[!is.na(dat.til$Percent.Flowers), ]
dat.til$doy <- 
    paste(dat.til$Year, dat.til$Month, dat.til$Day, sep = '-') |>
    as.Date() |>
    format("%j") |>
    as.numeric()

