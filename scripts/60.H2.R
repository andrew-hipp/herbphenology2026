# testing hypothesis 2

library(lme4)
library(lmerTest)
# dat.tests <- dat_ph
# for(i in names(dat.tests)) {
#     dat.tests[[i]] <- 
#         dat.tests[[i]][which(dat.tests[[i]]$spClean %in% keepsies[[i]]), ]
# }
# names(dat.tests) <- names(dat_ph)

# dat.tests.strict <- list(
#     early = dat_ph[[1]][which(dat.tests[[1]]$spClean %in% keepsies$earlyAndPeak), ],
#     peak = dat_ph[[1]][which(dat.tests[[2]]$spClean %in% keepsies$earlyAndPeak), ]
# )


lmerorigin <- list(
    early = lmer(doy ~  Europe + Asia + NAm + (1 | spClean), dat.tests[[1]]),
    peak = lmer(doy ~   Europe + Asia + NAm + (1 | spClean), dat.tests[[2]]),
    earlyStrict = lmer(doy ~  Europe + Asia + NAm + (1 | spClean), dat.tests.strict$early),
    peakStrict = lmer(doy ~   Europe + Asia + NAm + (1 | spClean), dat.tests.strict$peak)
)


#ggplot(dat.distro, aes(x= Chicago Native, fill= Chicago Native)) + geom_bar (color= )

