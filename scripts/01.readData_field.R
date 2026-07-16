## TO DO
### Read and format field data
### make a decision about 4-sides of field data... probably this 
###   will go into a separate data frame just for Tilia americana
###   Plan: separate out til am data and add in field data for a subset of analyses

dat.field = read.xlsx('data/Field_Data.xlsx')


### cleanup
for(i in c("Percent.Buds", "Percent.Flowers", "Percent.Fruit")) {
    class(dat.field[[i]]) <- "numeric"
    dat.field[[i]] <- dat.field[[i]] * 100
}

write.csv(dat.field, 'out/excluded_field.csv')


# need to update
dat.field$doy <- 
    paste(dat.field$Year, dat.field$Month, dat.field$Day, sep = '-') |>
    as.Date() |>
    format("%j") |>
    as.numeric()


write.csv(dat.field, 'out/dat.field.cleaned.csv')
rm(i, temp, temp.rowsExclude, colsToUse)
