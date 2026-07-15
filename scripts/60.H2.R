# ---------------------------------------------------------------------------
# Written by Claude (Anthropic) in an interactive Claude Code session with
# Andrew Hipp <ahipp@mortonarb.org>, 2026-07-15. Review before relying on results.
# ---------------------------------------------------------------------------

# testing hypothesis 2
# H2: Does CLIMATE SENSITIVITY of flowering differ between species native to
#     North America (NAm == "T") and non-native species?
#
# Climate sensitivity (CS) = the slope of flowering day (doy) on spring
# temperature. We test it with a single mixed model per temperature window:
#
#     doy ~ Temp * NAm + (Temp | spClean)
#
# - Temp             : average CS (doy-vs-temperature slope) for non-native spp (ref)
# - Temp:NAmT        : *** the H2 test *** -- how native spp CS differs from non-native
# - (Temp | spClean) : each species gets its own slope (its own CS) and intercept,
#                      so specimens within a species are not treated as independent
#                      and noisy species-level slopes are partially pooled.
#
# NAm is a species-level trait, so this is a between-species test: the effective
# sample size is the number of native vs non-native SPECIES, not specimens.

library(lme4)
library(lmerTest)

if(!exists('dat_ph')) stop('** Run scripts 00-30 (or 000.doItAll.R) before this one **')

## peak-flowering specimens (phenophases 4-6) with a clean native/non-native factor
dat.h2 <- dat_ph$ph4.6
dat.h2$NAm <- factor(trimws(dat.h2$NAm), levels = c('F', 'T'))  # ref = F (non-native)

## drop specimens whose species has no distribution info (NAm not scored), or no doy
nDropped <- sum(is.na(dat.h2$NAm) | is.na(dat.h2$doy))
if(nDropped > 0) message(paste('** H2: dropping', nDropped,
    'peak specimens with no NAm info or no doy **'))
dat.h2 <- dat.h2[!is.na(dat.h2$NAm) & !is.na(dat.h2$doy), ]

## how many SPECIES in each group -- this drives the real power of the test
message('** H2 species per group (peak): **')
print(tapply(dat.h2$spClean, dat.h2$NAm, function(x) length(unique(x))))

## climate sensitivity ~ nativity, one model per spring temperature window
## (same windows used in H1: Feb-Apr, Mar-May, Apr-Jun)
h2.CS <- list(
    T2_4 = lmer(doy ~ T2_4 * NAm + (T2_4 | spClean), data = dat.h2),
    T3_5 = lmer(doy ~ T3_5 * NAm + (T3_5 | spClean), data = dat.h2),
    T4_6 = lmer(doy ~ T4_6 * NAm + (T4_6 | spClean), data = dat.h2)
)

## NOTE ON THE CONVERGENCE WARNING ------------------------------------------
## These fits may print: "Model failed to converge with max|grad| = 0.0117
## (tol = 0.002)". This is a KNOWN false positive from lme4's over-sensitive
## gradient check, triggered here because temperature (~10-20) and doy (1-365)
## are on very different scales. We confirmed the fit is fine on 2026-07-15 with:
##     lme4::allFit(h2.CS$T2_4)
## all 5 optimizers converged and agreed on the log-likelihood to within 5e-9,
## i.e. they found the same solution. So the estimates are trustworthy.
##
## We deliberately do NOT center/scale temperature: keeping it in real units (deg C)
## lets us read the slopes (climate sensitivity) directly as days-per-degree.
## Centering would silence the warning but is purely cosmetic and would make the
## intercept / NAm main effect harder to interpret in real terms.
## --------------------------------------------------------------------------

## The H2 answer is the 'Temp:NAmT' interaction row in each summary:
##   negative  -> native spp flower EARLIER per degree of warming (more sensitive)
##   positive  -> native spp are LESS sensitive than non-native
lapply(h2.CS, summary)

## --- AIC comparison: which spring temperature window fits best? -------------
## The three models differ only in the temperature predictor (same response,
## same random structure). Two requirements for a valid AIC comparison:
##  (1) ML, not REML -- REML likelihoods are NOT comparable across models with
##      different fixed-effect predictors, so we refit with REML = FALSE here.
##      (The REML fits in h2.CS above are still what we report coefficients from.)
##  (2) identical rows -- every model must see the same observations, so we keep
##      only rows where all three windows are present.
dat.aic <- dat.h2[complete.cases(dat.h2[, c('T2_4', 'T3_5', 'T4_6')]), ]
if(nrow(dat.aic) < nrow(dat.h2))
    message(paste('** H2 AIC: using', nrow(dat.aic), 'of', nrow(dat.h2),
        'peak specimens with all three temperature windows present **'))

h2.CS_ML <- list(
    T2_4 = lmer(doy ~ T2_4 * NAm + (T2_4 | spClean), data = dat.aic, REML = FALSE),
    T3_5 = lmer(doy ~ T3_5 * NAm + (T3_5 | spClean), data = dat.aic, REML = FALSE),
    T4_6 = lmer(doy ~ T4_6 * NAm + (T4_6 | spClean), data = dat.aic, REML = FALSE)
)

## AIC table with delta-AIC and Akaike weights
aic.vals <- sapply(h2.CS_ML, AIC)
aic.tab <- data.frame(
    model  = names(aic.vals),
    AIC    = round(aic.vals, 2),
    dAIC   = round(aic.vals - min(aic.vals), 2)
)
## Akaike weight = relative likelihood of each model, normalized to sum to 1;
## interpretable as the probability that model is the best of this set (by K-L).
aic.tab$weight <- round(
    exp(-0.5 * aic.tab$dAIC) / sum(exp(-0.5 * aic.tab$dAIC)), 3)
aic.tab <- aic.tab[order(aic.tab$AIC), ]

message('** H2: AIC comparison of temperature windows (ML fits) **')
print(aic.tab, row.names = FALSE)
message(paste0('** Best-fit temperature window by AIC: ', aic.tab$model[1],
    ' (dAIC = 0, Akaike weight = ', aic.tab$weight[1], ') **'))

## The benign gradient warning above is NOT a reason to use this fallback (see the
## allFit note). Only switch to random-intercept-only if a model is genuinely
## degenerate -- check with isSingular(h2.CS$T2_4); if that returns TRUE (can happen
## when some species have few specimens or a narrow temperature range), use this
## version instead. It still tests the Temp:NAm interaction but does not let each
## species have its own slope:

# Native to Asia
if(!exists('dat_ph')) stop('** Run scripts 00-30 (or 000.doItAll.R) before this one **')
dat.h2 <- dat_ph$ph4.6
dat.h2$Asia <- factor(trimws(dat.h2$Asia), levels = c('F', 'T'))  # ref = F (non-native)

nDroppedAsia <- sum(is.na(dat.h2$Asia) | is.na(dat.h2$doy))
if(nDroppedAsia > 0) message(paste('** H2: dropping', nDroppedAsia,
    'peak specimens with no Asia info or no doy **'))
dat.h2 <- dat.h2[!is.na(dat.h2$Asia) & !is.na(dat.h2$doy), ]

message('** H2 species per group (peak): **')
print(tapply(dat.h2$spClean, dat.h2$Asia, function(x) length(unique(x))))

## climate sensitivity ~ nativity March-May
h2.As <- list( T3_5 = lmer(doy ~ T3_5 * Asia + (T3_5 | spClean), data = dat.h2))
lapply(h2.As, summary)

#Native to Europe
if(!exists('dat_ph')) stop('** Run scripts 00-30 (or 000.doItAll.R) before this one **')
dat.h2 <- dat_ph$ph4.6
dat.h2$Europe <- factor(trimws(dat.h2$Europe), levels = c('F', 'T'))  # ref = F (non-native)

nDroppedEurope <- sum(is.na(dat.h2$Europe) | is.na(dat.h2$doy))
if(nDroppedEurope > 0) message(paste('** H2: dropping', nDroppedEurope,
    'peak specimens with no Europe info or no doy **'))
dat.h2 <- dat.h2[!is.na(dat.h2$Europe) & !is.na(dat.h2$doy), ]

message('** H2 species per group (peak): **')
print(tapply(dat.h2$spClean, dat.h2$Europe, function(x) length(unique(x))))

## climate sensitivity ~ nativity March-May
h2.Eu <- list( T3_5 = lmer(doy ~ T3_5 * Europe + (T3_5 | spClean), data = dat.h2))
lapply(h2.Eu, summary)

#Native to Chicago
if(!exists('dat_ph')) stop('** Run scripts 00-30 (or 000.doItAll.R) before this one **')
dat.h2 <- dat_ph$ph4.6
dat.h2$chicagoNative <- factor(trimws(dat.h2$chicagoNative), levels = c('F', 'T'))  # ref = F (non-native)

nDroppedChicago <- sum(is.na(dat.h2$chicagoNative) | is.na(dat.h2$doy))
if(nDroppedChicago > 0) message(paste('** H2: dropping', nDroppedChicago,
    'peak specimens with no Chicago info or no doy **'))
dat.h2 <- dat.h2[!is.na(dat.h2$chicagoNative) & !is.na(dat.h2$doy), ]

message('** H2 species per group (peak): **')
print(tapply(dat.h2$spClean, dat.h2$chicagoNative, function(x) length(unique(x))))

## climate sensitivity ~ nativity March-May
h2.Chicago <- list( T3_5 = lmer(doy ~ T3_5 * chicagoNative + (T3_5 | spClean), data = dat.h2))
lapply(h2.Chicago, summary)

#Miriam is writing

h2plotchi_peak <- ggplot(dat.h2, aes(x = chicagoNative, y = doy, fill=chicagoNative))
h2plotchi_peak <- h2plotchi_peak + 
geom_boxplot() +
theme_bw () +
theme (legend.position = "none", axis.text.x = element_blank()) +
labs (title = "Peak Bloom climate sensitivity by Nativity Status", x = "Chicago Distribution", y = "Day of Year") +
  scale_fill_manual(values = c("#cb76ff", "#e1d600"))

print(h2plotchi_peak)

##I don't think non-native to chicago and to north america are the same so need to check and then switch this for other h2plotAm_peak
#dat.h2.NAmT = dplyr::filter(dat.h2, NAm == "T")
#h2plotAm_peak <- ggplot(dat.h2.NAmT, aes(x = NAm, y = doy, fill= NAm))
#h2plotAm_peak <- h2plotAm_peak + 
#geom_boxplot() +
#theme_bw () +
    #theme (legend.position = "none") +
#labs (x = "North America Distribution",
       #y = "Day of Year", ) +
  #scale_fill_manual(values = c("#e1d600"))


h2plotAm_peak <- ggplot(dat.h2, aes(x = NAm, y = doy, fill= NAm))
h2plotAm_peak <- h2plotAm_peak + 
geom_boxplot() +
theme_bw () +
    theme (legend.position = "none", axis.text.x = element_blank()) +
labs (x = "North America Distribution",
       y = "Day of Year", ) +
  scale_fill_manual(values = c("#cb76ff", "#e1d600"))


print(h2plotAm_peak)

h2plotAsia_peak <- ggplot(dat.h2, aes(x = Asia, y = doy, fill=Asia))
h2plotAsia_peak <- h2plotAsia_peak + 
geom_boxplot() +
theme_bw () +
theme (legend.position = "none", axis.text.x = element_blank()) +
labs (x = "Asia Distribution", y = "Day of Year") +
  scale_fill_manual(values = c("#cb76ff", "#e1d600"))

print(h2plotAsia_peak)

h2plotEurope_peak <- ggplot(dat.h2, aes(x = Europe, y = doy, fill=Europe))
h2plotEurope_peak <- h2plotEurope_peak + 
geom_boxplot() +
theme_bw () +
    theme (legend.title = element_blank(), axis.text.x = element_blank()) +
labs (x = "Europe Distribution", y = "Day of Year") +
  scale_fill_manual(values = c("#cb76ff", "#e1d600"), labels = c("Non-Native", "Native"))

print(h2plotEurope_peak)

h2plotchi_peak + h2plotAm_peak + h2plotAsia_peak + h2plotEurope_peak
