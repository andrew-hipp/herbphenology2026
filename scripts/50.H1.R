# testing hypothesis 1
# install.packages("lmerTest")

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

lmerTests_yr <- list(
    early = lmer(doy ~ Year + (1 | spClean), dat.tests[[1]]),
    peak = lmer(doy ~ Year + (1 | spClean), dat.tests[[2]]),
    late = lmer(doy ~ Year + (1 | spClean), dat.tests[[3]]),
    earlyStrict = lmer(doy ~ Year + (1 | spClean), dat.tests.strict$early),
    peakStrict = lmer(doy ~ Year + (1 | spClean), dat.tests.strict$peak)
)

lmerTests_2_4 <- list(
    early = lmer(doy ~ T2_4 + (1 | spClean), dat.tests[[1]]),
    peak = lmer(doy ~ T2_4 + (1 | spClean), dat.tests[[2]]),
    late = lmer(doy ~ T2_4 + (1 | spClean), dat.tests[[3]]),
    earlyStrict = lmer(doy ~ T2_4 + (1 | spClean), dat.tests.strict$early),
    peakStrict = lmer(doy ~ T2_4 + (1 | spClean), dat.tests.strict$peak)
)

lmerTests_3_5 <- list(
    early = lmer(doy ~ T3_5 + (1 | spClean), dat.tests[[1]]),
    peak = lmer(doy ~ T3_5 + (1 | spClean), dat.tests[[2]]),
    late = lmer(doy ~ T3_5 + (1 | spClean), dat.tests[[3]]),
    earlyStrict = lmer(doy ~ T3_5 + (1 | spClean), dat.tests.strict$early),
    peakStrict = lmer(doy ~ T3_5 + (1 | spClean), dat.tests.strict$peak)
)

lmerTests_4_6 <- list(
    early = lmer(doy ~ T4_6 + (1 | spClean), dat.tests[[1]]),
    peak = lmer(doy ~ T4_6 + (1 | spClean), dat.tests[[2]]),
    late = lmer(doy ~ T4_6 + (1 | spClean), dat.tests[[3]]),
    earlyStrict = lmer(doy ~ T4_6 + (1 | spClean), dat.tests.strict$early),
    peakStrict = lmer(doy ~ T4_6 + (1 | spClean), dat.tests.strict$peak)
)

#Precipitation
#lmerTests_11_1 <- list(
   # early = lmer(doy ~ P11_1 + (1 | spClean), dat.tests[[1]]),
   # peak = lmer(doy ~ P11_1 + (1 | spClean), dat.tests[[2]]),
   # late = lmer(doy ~ P11_1 + (1 | spClean), dat.tests[[3]]),
   # earlyStrict = lmer(doy ~ P11_1 + (1 | spClean), dat.tests.strict$early),
   # peakStrict = lmer(doy ~ P11_1 + (1 | spClean), dat.tests.strict$peak)
#)

# lmerTests_12_2 <- list(
   # early = lmer(doy ~ P12_2 + (1 | spClean), dat.tests[[1]]),
   # peak = lmer(doy ~ P12_2 + (1 | spClean), dat.tests[[2]]),
   # late = lmer(doy ~ P12_2 + (1 | spClean), dat.tests[[3]]),
   # earlyStrict = lmer(doy ~ P12_2 + (1 | spClean), dat.tests.strict$early),
   # peakStrict = lmer(doy ~ P12_2 + (1 | spClean), dat.tests.strict$peak)
#)


## to get the results, take a look here:
lapply(lmerTests_yr, summary)
# Feb-Apr
lapply(lmerTests_2_4, summary)
#Mar-May
lapply(lmerTests_3_5, summary)
#Apr-June
lapply(lmerTests_4_6, summary)

## and to plot everything
h1plot_peak <- ggplot(dat.tests[[2]], aes(x = Year, y = doy, color = spClean))
h1plot_peak <- h1plot_peak + geom_point() + geom_smooth(method = 'lm')
print(h1plot_peak)











##My mom ask me to do...
#residuals_vector <- residuals(lmerTests_yr$peak)

#hist(residuals_vector, main = "Hist of Residuals", xlab = "Residuals", col = "blue")
#shapiro.test(residuals_vector)

