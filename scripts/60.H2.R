# testing hypothesis 2

dat.tests <- dat_ph
for(i in names(dat.tests)) {
    dat.tests[[i]] <- 
        dat.tests[[i]][which(dat.tests[[i]]$spClean %in% keepsies[[i]]), ]
}
names(dat.tests) <- names(dat_ph)

dat.tests.strict <- list(
    early = dat_ph[[1]][which(dat.tests[[1]]$spClean %in% keepsies$earlyAndPeak), ],
    peak = dat_ph[[1]][which(dat.tests[[2]]$spClean %in% keepsies$earlyAndPeak), ]
)


lmerorigin <- list(
    early = lmer(doy ~  + (1 | spClean), dat.tests[[1]]),
    peak = lmer(doy ~  + (1 | spClean), dat.tests[[2]]),
    earlyStrict = lmer(doy ~ + (1 | spClean), dat.tests.strict$early),
    peakStrict = lmer(doy ~  + (1 | spClean), dat.tests.strict$peak)
)


#ggplot(dat.distro, aes(x= Chicago Native, fill= Chicago Native)) + geom_bar (color= )