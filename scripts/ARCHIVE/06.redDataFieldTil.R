library(openxlsx)
library(ggplot2)

dat.field <- read.xlsx('data/Field_Data.xlsx')
for(i in c("Percent.Buds", "Percent.Flowers", 
"Percent.Fruit")) {
    class(dat.field[[i]]) <- "numeric"
    dat.field[[i]] <- dat.field[[i]] * 100
}

dat.field <- dat.field[!is.na(dat.field$Percent.Flowers), ]
