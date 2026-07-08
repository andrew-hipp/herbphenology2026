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

## now clean up the rbind'ed matrix
### cleanup 1
dat.mat <- dat.mat[!is.na(as.numeric(dat.mat$SpecimenAccession)),]
row.names(dat.mat) <- make.unique(as.character(dat.mat$SpecimenAccession))

### cleanup 2
for(i in c("Buds", "Flowers", "Fruits")) {
    class(dat.mat[[i]]) <- "numeric"
}

### cleanup 3
temp.rowsExclude <- which(is.na(dat.mat$Buds) | is.na(dat.mat$Flower) | is.na(dat.mat$Fruits))
write.csv(dat.mat[temp.rowsExclude, ], 'out/excluded_cleanup3.csv')
dat.mat <- dat.mat[-temp.rowsExclude, ]

### cleanup 4
for(i in c("Percent.Buds", "Percent.Flowers", "Percent.Fruit")) {
    class(dat.mat[[i]]) <- "numeric"
    dat.mat[[i]] <- dat.mat[[i]] * 100
}

temp.rowsExclude <- which(is.na(dat.mat$Percent.Flowers))
write.csv(dat.mat[temp.rowsExclude, ], 'out/excluded_cleanup4.csv')
dat.mat <- dat.mat[-temp.rowsExclude, ]

stop('left off here')

dat.mat$doy <- 
    paste(dat.mat$Year, dat.mat$Month, dat.mat$Day, sep = '-') |>
    as.Date() |>
    format("%j") |>
    as.numeric()

write.csv(dat.mat, 'out/dat.mat.cleaned.csv')
rm(i, temp, temp.rowsExclude, colsToUse)
