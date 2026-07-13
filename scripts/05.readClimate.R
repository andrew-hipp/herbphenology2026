library(openxlsx)

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

dat.clim_avg <- dat.clim %>%
  mutate(
    year = YEAR,
    month = MONTH  
    ) %>%
  group_by(year, month) %>%
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
