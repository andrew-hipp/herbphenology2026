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

p=ggplot(dat.til_am, aes( x=Year, y=Percent.Flowers))
p= p+geom_point()
print(p)