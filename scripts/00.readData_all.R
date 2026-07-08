# reads all data, checks to make sure columns are the same, rbinds

require(openxlsx)

## summarize what taxa we have in the green specimens
dat.gr <- read.xlsx('data/Herbarium_GREEN_Specimens.xlsx')
dat.gr.summary <- 
    table(dat.gr$CalcFullName) |> 
    sort(decreasing = T)
write.csv(dat.gr.summary, 'out/dat.gr.summary.csv')

dat.list <- list(
    dat.til = read.xlsx('data/Tilia_everything_else.xlsx'),
    dat.tilam = read.xlsx('data/Tilia_americana.xlsx'),
    dat.cer = read.xlsx('data/Cercis.xlsx'),
    dat.acer = read.xlsx('data/Acer.xlsx')
)

## check columns just to be sure
temp <- sapply(dat.list, names)
if(!Reduce(identical,temp)) warning('** data headers do not all match... beware!! **')
colsToUse <- Reduce(intersect, temp)

dat.list <- lapply(dat.list, function(x) x[,colsToUse])
dat.mat <- Reduce(rbind, dat.list)
