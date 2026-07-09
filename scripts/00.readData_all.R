# reads all data, checks to make sure columns are the same, rbinds

require(openxlsx)

## TO DO
### Read and format field data
### make a decision about 4-sides of field data... probably this 
###   will go into a separate data frame just for Tilia americana
###   Plan: separate out til am data and add in field data for a subset of analyses

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

dat.nameFixes <- read.xlsx('data/nameFixes.xlsx', rowNames = TRUE)
nameFixes <- vector('character', 0)
for(i in row.names(dat.nameFixes)) {
    whichDo <- which(dat.mat$DeterminationCalcFullName == i)
    nameFixes <- c(nameFixes, 
        paste('** Replacing', length(whichDo), 'instances of', i)
        ) # close c
    dat.mat$DeterminationCalcFullName[whichDo] <- dat.nameFixes[i, 'new']
}
writeLines(nameFixes, 'out/nameFixes.log')

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

dat.mat$doy <- 
    paste(dat.mat$Year, dat.mat$Month, dat.mat$Day, sep = '-') |>
    as.Date() |>
    format("%j") |>
    as.numeric()

temp <- dat.mat$DeterminationCalcFullName
temp <- strsplit(temp, " ", fixed = T)
temp <- sapply(temp, function(x) paste(x[1:min(2, length(x))], collapse = ' '))
dat.mat$spClean <- temp

dat.mat$cult <- F
dat.mat$hyb <- F

dat.mat$cult[grep("'", dat.mat$DeterminationCalcFullName)] <- T
dat.mat$hyb[grep("×", dat.mat$DeterminationCalcFullName)] <- T

write.csv(dat.mat, 'out/dat.mat.cleaned.csv')
rm(i, temp, temp.rowsExclude, colsToUse)



