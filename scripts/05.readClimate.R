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
