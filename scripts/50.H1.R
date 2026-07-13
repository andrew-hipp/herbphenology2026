# testing hypothesis 1

library(lme4)
library(lmerTest)
library(ggplot2)

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

lmerTests <- list(
    early = lmer(doy ~ Year + (1 | spClean), dat.tests[[1]]),
    peak = lmer(doy ~ Year + (1 | spClean), dat.tests[[2]]),
    late = lmer(doy ~ Year + (1 | spClean), dat.tests[[3]]),
    earlyStrict = lmer(doy ~ Year + (1 | spClean), dat.tests.strict$early),
    peakStrict = lmer(doy ~ Year + (1 | spClean), dat.tests.strict$peak)
)

## to get the results, take a look here:
lapply(lmerTests, summary)

## and to plot everything
h1plot_peak <- ggplot(dat.tests[[2]], aes(x = Year, y = doy, color = spClean))
h1plot_peak <- h1plot_peak + geom_point() + geom_smooth(method = 'lm')
print(h1plot_peak)
