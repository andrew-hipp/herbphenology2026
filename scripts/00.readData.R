library(openxlsx)
library(ggplot2)
dat.gr <- read.xlsx('data/Herbarium_GREEN_Specimens.xlsx')

dat.gr.summary <- 
    table(dat.gr$CalcFullName) |> 
    sort(decreasing = T)
write.csv(dat.gr.summary, 'out/dat.gr.summary.csv')

dat.til_am <- read.xlsx('data/Tilia_americana_all.xlsx')
dat.til_am <- dat.til_am[!is.na(dat.til_am$SpecimenAccession),]
row.names(dat.til_am) <- dat.til_am$SpecimenAccession
for(i in c("Buds", "Flowers", "Fruits")) {
    class(dat.til_am[[i]]) <- "numeric"
}

for(i in c("Percent.Buds", "Percent.Flowers", 
"Percent.Fruit")) {
    class(dat.til_am[[i]]) <- "numeric"
    dat.til_am[[i]] <- dat.til_am[[i]] * 100
}

dat.til_am <- dat.til_am[!is.na(dat.til_am$Percent.Flowers), ]
dat.til_am$doy <- 
    paste(dat$Year, dat$Month, dat$Day, sep = '-') |>
    as.Date() |>
    format("%j") |>
    as.numeric()

p <- ggplot(dat.til_am, aes(x=Year, y=Percent.Flowers))
p <- p+geom_point() + geom_smooth(method = 'lm')
ggsave('out/firstBasicPlot.pdf')
