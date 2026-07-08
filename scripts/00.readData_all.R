# reads all data, checks to make sure columns are the same, rbinds

require(openxlsx)

dat.gr <- read.xlsx('data/Herbarium_GREEN_Specimens.xlsx')
dat.gr.summary <- 
    table(dat.gr$CalcFullName) |> 
    sort(decreasing = T)
write.csv(dat.gr.summary, 'out/dat.gr.summary.csv')

dat.til <- 
dat.tilam <- 
dat.cer <- 
dat.acer <- 