library(openxlsx)
library(dplyr)

dat.dist <- 
    read.xlsx('data/Distribution.xlsx', rowNames = T)

dat.clim <- list(
    young = read.xlsx('data/climate_young.xlsx'),
    old = read.xlsx('data/climate_old.xlsx')
)
temp <- intersect(names(dat.clim$young), names(dat.clim$old))

dat.clim <- rbind(dat.clim$young[temp], dat.clim$old[temp]) |>
  as.data.frame()

dat.clim$YEAR <- sapply(
    strsplit(dat.clim$DATE, '-', fixed = T), 
    '[',
    1)

dat.clim$MONTH <- sapply(
    strsplit(dat.clim$DATE, '-', fixed = T), 
    '[',
    2)

dat.clim_avg <- dat.clim |>
  mutate(
    year = YEAR,
    month = MONTH  
    ) |>
  group_by(year, month) |>
  summarize(TMAX_avg = mean(TMAX/10, na.rm = TRUE), .groups = "drop") %>%
  as.data.frame

temp <- split(dat.clim_avg, dat.clim_avg$year)

dat.clim_byYear <- data.frame(
    year = names(temp),
    row.names = names(temp)
)
dat.clim_byYear$T2_4 <- 
    dat.clim_byYear$T3_5 <-
    dat.clim_byYear$T4_6 <-
    NA

for(i in row.names(dat.clim_byYear)) {
    dat.clim_byYear[i, 'T2_4'] = 
        mean(temp[[i]][temp[[i]]$month %in% c('02', '03', '04'), 'TMAX_avg'], na.rm = T)
    dat.clim_byYear[i, 'T3_5'] = 
        mean(temp[[i]][temp[[i]]$month %in% c('03', '04', '05'), 'TMAX_avg'], na.rm = T)
    dat.clim_byYear[i, 'T4_6'] = 
        mean(temp[[i]][temp[[i]]$month %in% c('04', '05', '06'), 'TMAX_avg'], na.rm = T)

}

# ## add averages to dat.mat
dat.mat <- cbind(dat.mat, dat.clim_byYear[as.character(dat.mat$Year), ])






#Precipitation

dat.clim$YEAR_num  <- as.numeric(dat.clim$YEAR)
dat.clim$MONTH_num <- as.numeric(dat.clim$MONTH)

# Create a "Climate Year" column (Months 11 and 12 join the next calendar year)
dat.clim$CLIM_YEAR <- ifelse(dat.clim$MONTH_num %in% c(11, 12), 
                             dat.clim$YEAR_num + 1, 
                             dat.clim$YEAR_num)

dat.clim$CLIM_YEAR <- as.character(dat.clim$CLIM_YEAR)

# dividing by 10 give precipitation in mm
dat.prcp_avg <- dat.clim |>
  group_by(CLIM_YEAR, MONTH) |>
  summarize(PRCP_sum = sum(PRCP/10, na.rm = TRUE), .groups = "drop") %>%
  as.data.frame

prcp_shifted <- split(dat.prcp_avg, dat.prcp_avg$CLIM_YEAR)

dat.PRCP_byYear <- data.frame(
    year = names(prcp_shifted),
    row.names = names(prcp_shifted)
)
dat.PRCP_byYear$P11_1 <- 
    dat.PRCP_byYear$P12_2 <-
    NA

for(i in row.names(dat.PRCP_byYear)) {
    dat.PRCP_byYear[i, "P11_1"] = 
        sum(prcp_shifted[[i]][prcp_shifted[[i]]$MONTH %in% c('11', '12', '01'), 'PRCP_sum'], na.rm = T)
    dat.PRCP_byYear[i, "P12_2"] = 
        sum(prcp_shifted[[i]][prcp_shifted[[i]]$MONTH %in% c('12', '01', '02'), 'PRCP_sum'], na.rm = T)
}

## add averages to dat.mat
dat.mat <- cbind(dat.mat, dat.PRCP_byYear[as.character(dat.mat$Year), ])

## add distributions to dat.mat
dat.mat <- cbind(dat.mat, dat.dist[dat.mat$spClean, ])
write.csv(dat.mat, 'out/dat.mat.withMetadata.csv')