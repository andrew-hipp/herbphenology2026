# H3 Earlier flowering phases will exhibit greater climate sensitivity than later flowering phases

library(lme4)
library(lmerTest)

early.dat <- dat.tests[[1]] |> mutate(phase = "Early")
peak.dat  <- dat.tests[[2]] |> mutate(phase = "Peak")
late.dat  <- dat.tests[[3]] |> mutate(phase = "Late")

dat.phases <- bind_rows(early.dat, peak.dat, late.dat)

dat.phases$phase <- factor(dat.phases$phase,levels = c("Early", "Peak", "Late"))
#They all finally line up so they are pulling the right data
dat.phases$phase <- relevel(dat.phases$phase, ref = "Early")
dat.h3.early <- lmer(doy ~ T3_5 * phase + (1 | spClean), data = dat.phases)
summary(dat.h3.early)

dat.phases$phase <- relevel(dat.phases$phase, ref = "Peak")
dat.h3.peak <- lmer(doy ~ T3_5 * phase + (1 | spClean), data = dat.phases)
summary(dat.h3.peak)

dat.phases$phase <- relevel(dat.phases$phase, ref = "Late")
dat.h3.late <- lmer(doy ~ T3_5 * phase + (1 | spClean), data = dat.phases)
summary(dat.h3.late)

#Early flowering experiences .2776 days more day increase for every degree C but not statistically significant p=0.576

dat.tests.strict <- list(
    early = dat_ph[[1]][which(dat.tests[[1]]$spClean %in% keepsies$earlyAndPeak), ],
    peak = dat_ph[[1]][which(dat.tests[[2]]$spClean %in% keepsies$earlyAndPeak), ]
)
early.dat.strict <- dat.tests.strict[[1]] |> mutate(phase = "earlyStrict")
peak.dat.strict <- dat.tests.strict[[2]] |> mutate(phase = "peakStrict")

dat.earlyandpeak.strict <- bind_rows(early.dat.strict, peak.dat.strict)

dat.strict.h3 = lmer(doy ~ T3_5 * phase + (1 | spClean), data = dat.earlyandpeak.strict)
summary(dat.strict.h3)
