# do plots by sp and phenophase
require(ggplot2)

if(!exists('keepsies')) stop("you MUST run 30 first!!")
stats <- 
for(i in names(keepsies)) {
    for(j in keepsies[[i]]) {
        dat.plot <- dat_ph[[i]][dat_ph[[i]]$spClean == j, ]
        p <- ggplot(dat.plot, aes(x = Year, y = doy))
        p <- p + geom_point() + 
                geom_smooth(aes(group = 1), method = 'lm', color= "black", se= TRUE) 
        ggsave(paste('out/', i, '_', j, '.pdf', sep = ''))
        lm(doy ~ Year, data = dat.plot) |> summary() |> print()
    } # close j
} # close i