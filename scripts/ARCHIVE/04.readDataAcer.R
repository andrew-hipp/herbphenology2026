library(openxlsx)
library(ggplot2)
dat.gr <- read.xlsx('data/Herbarium_GREEN_Specimens.xlsx')

dat.gr.summary <- 
    table(dat.gr$CalcFullName) |> 
    sort(decreasing = T)
write.csv(dat.gr.summary, 'out/dat.gr.summary.csv')

dat.acer <- read.xlsx('data/Acer.xlsx')
dat.acer <- dat.acer[!is.na(dat.acer$SpecimenAccession),]
row.names(dat.acer) <- dat.acer$SpecimenAccession
for(i in c("Buds", "Flowers", "Fruits")) {
    class(dat.acer[[i]]) <- "numeric"
}

for(i in c("Percent.Buds", "Percent.Flowers", 
"Percent.Fruit")) {
    class(dat.acer[[i]]) <- "numeric"
    dat.acer[[i]] <- dat.acer[[i]] * 100
}

dat.acer <- dat.acer[!is.na(dat.acer$Percent.Flowers), ]
dat.acer$doy <- 
    paste(dat.acer$Year, dat.acer$Month, dat.acer$Day, sep = '-') |>
    as.Date() |>
    format("%j") |>
    as.numeric()

