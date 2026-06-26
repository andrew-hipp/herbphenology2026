library(openxlsx)
library(ggplot2)

dat.cer <- read.xlsx('data/Cercis.xlsx')
dat.cer <- dat.cer[!is.na(dat.cer$SpecimenAccession),]
row.names(dat.cer) <- dat.cer$SpecimenAccession
for(i in c("Buds", "Flowers", "Fruits")) {
    class(dat.cer[[i]]) <- "numeric"
}

for(i in c("Percent.Buds", "Percent.Flowers", 
"Percent.Fruit")) {
    class(dat.cer[[i]]) <- "numeric"
    dat.cer[[i]] <- dat.cer[[i]] * 100
}

dat.cer <- dat.cer[!is.na(dat.cer$Percent.Flowers), ]
dat.cer$doy <- 
    paste(dat.cer$Year, dat.cer$Month, dat.cer$Day, sep = '-') |>
    as.Date() |>
    format("%j") |>
    as.numeric()

