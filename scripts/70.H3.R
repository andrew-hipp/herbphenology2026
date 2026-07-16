# H3 Earlier flowering phases will exhibit greater climate sensitivity than later flowering phases


early.dat <- dat.tests[[1]] |> mutate(phase = "Early")
peak.dat <- dat.tests[[2]] |> mutate(phase = "Peak")

dat.earlyandpeak <- bind_rows(early.dat, peak.dat)

dat.h3 = lmer(doy ~ T3_5 * phase + (1 | spClean), data = dat.earlyandpeak)
summary(dat.h3)
#Early flowering experiences .2776 days more day increase for every degree C but not statistically significant p=0.576

early.dat.strict <- dat.tests[[1]] |> mutate(phase = "earlyStrict")
peak.dat.strict <- dat.tests[[2]] |> mutate(phase = "peakStrict")

dat.earlyandpeak.strict <- bind_rows(early.dat.strict, peak.dat.strict)

dat.strict.h3 = lmer(doy ~ T3_5 * phase + (1 | spClean), data = dat.earlyandpeak.strict)
summary(dat.strict.h3)
# I got same values so can't be correct...