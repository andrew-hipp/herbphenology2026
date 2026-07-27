# testing hypothesis 1
# install.packages("lmerTest")

library(lme4)
library(lmerTest)
library(ggplot2)
library(dplyr)
library(broom)


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
    peakStrict = lmer(doy ~ Year + (1 | spClean), dat.tests.strict$peak),
    All_together = lmer(doy ~ Year + (1 | spClean), data = bind_rows(dat.test)),
     All_together_strict = lmer(doy ~ Year + (1 | spClean), data = bind_rows(dat.tests.strict))
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
    peakStrict = lmer(doy ~ T3_5 + (1 | spClean), dat.tests.strict$peak),
    All_together = lmer(doy ~ T3_5 + (1 | spClean), data = bind_rows(dat.tests)),
     All_together_strict = lmer(doy ~ T3_5 + (1 | spClean), data = bind_rows(dat.tests.strict))
)

lmerTests_4_6 <- list(
    early = lmer(doy ~ T4_6 + (1 | spClean), dat.tests[[1]]),
    peak = lmer(doy ~ T4_6 + (1 | spClean), dat.tests[[2]]),
    late = lmer(doy ~ T4_6 + (1 | spClean), dat.tests[[3]]),
    earlyStrict = lmer(doy ~ T4_6 + (1 | spClean), dat.tests.strict$early),
    peakStrict = lmer(doy ~ T4_6 + (1 | spClean), dat.tests.strict$peak)
)

#Precipitation
lmerTests_11_1 <- list(
   early = lmer(doy ~ P11_1 + (1 | spClean), dat.tests[[1]]),
   peak = lmer(doy ~ P11_1 + (1 | spClean), dat.tests[[2]]),
   late = lmer(doy ~ P11_1 + (1 | spClean), dat.tests[[3]]),
   earlyStrict = lmer(doy ~ P11_1 + (1 | spClean), dat.tests.strict$early),
   peakStrict = lmer(doy ~ P11_1 + (1 | spClean), dat.tests.strict$peak)
)

lmerTests_12_2 <- list(
   early = lmer(doy ~ P12_2 + (1 | spClean), dat.tests[[1]]),
   peak = lmer(doy ~ P12_2 + (1 | spClean), dat.tests[[2]]),
   late = lmer(doy ~ P12_2 + (1 | spClean), dat.tests[[3]]),
   earlyStrict = lmer(doy ~ P12_2 + (1 | spClean), dat.tests.strict$early),
   peakStrict = lmer(doy ~ P12_2 + (1 | spClean), dat.tests.strict$peak))

lmerTests1_12 <- list(
   early = lmer(doy ~ PYEAR + (1 | spClean), dat.tests[[1]]),
   peak = lmer(doy ~ PYEAR + (1 | spClean), dat.tests[[2]]),
   late = lmer(doy ~ PYEAR + (1 | spClean), dat.tests[[3]]),
   earlyStrict = lmer(doy ~ PYEAR + (1 | spClean), dat.tests.strict$early),
   peakStrict = lmer(doy ~ PYEAR + (1 | spClean), dat.tests.strict$peak), 
       All_together = lmer(doy ~ PYEAR + (1 | spClean), data = bind_rows(dat.tests)),
     All_together_strict = lmer(doy ~ PYEAR + (1 | spClean), data = bind_rows(dat.tests.strict)))


## to get the results, take a look here:
lapply(lmerTests_yr, summary)
# Feb-Apr
lapply(lmerTests_2_4, summary)
#Mar-May
lapply(lmerTests_3_5, summary)
#Apr-June
lapply(lmerTests_4_6, summary)
#Nov-Jan
lapply(lmerTests_11_1, summary)
#Dec-Feb
lapply(lmerTests_12_2, summary)
#Jan-Dec
lapply(lmerTests1_12, summary)

## and to plot everything
# Kierans Code V
dat.tests[[2]]$genus = strsplit(dat.tests[[2]]$spClean, " ") |> lapply(function(x) x[1]) |> unlist()
#First basic plot
h1plot_peakclear <- ggplot(dat.tests[[2]], aes(x = Year, y = doy, color = spClean)) + 
  geom_point() + geom_smooth(method = "lm", aes(group = 1), color = "black", se = TRUE, linewidth = 5) +
  theme_bw(base_size = 18) +
  labs(title = "Peak Flowering by Year", subtitle = "Trends across four genera", y = "Day of Year", color = "Species")
print(h1plot_peakclear)

# shape for genus
h1plot_peak <- ggplot(dat.tests[[2]], aes(x = Year, y = doy, color = spClean, shape = genus))
h1plot_peak <- h1plot_peak + 
geom_point() + 
  geom_smooth(method = "lm", aes(group = 1), color = "black", se = TRUE , linewidth= 5) +
theme_bw(base_size=18) +
labs(title = "Peak Flowering by Year", subtitle= "Trends across four genera", y= "Day of Year", color = "Species", )
print(h1plot_peak)

#genus lines 
## worried: are the genus lines an average of the genus and species or just the ones without species
h1plot_peak <- ggplot(dat.tests[[2]], aes(x = Year, y = doy, shape = genus)) +
  geom_point(aes(color = spClean)) + 
    geom_smooth(method = "lm", aes(group = genus, color = genus), se = FALSE, linewidth = 3) + 
    geom_smooth(method = "lm", aes(group = 1), color = "black", se = TRUE, linewidth = 5) + 
  theme_bw(base_size = 18) + 
  labs(title = "Peak Flowering by Year", subtitle = "Trends across four genera", y = "Day of Year", color = "Species", fill = "Genus")
print(h1plot_peak)

#Making the slopes a mega slope
species_slopes <- dat.tests[[2]] |> group_by(spClean) |> do(tidy(lm(doy ~ Year, data = .))) |> filter(term %in% c("(Intercept)", "Year")) |>
select(spClean, term, estimate) |> tidyr::pivot_wider(names_from = term, values_from = estimate) |> rename(intercept = `(Intercept)`, slope = Year)
avg_intercept <- mean(species_slopes$intercept)
avg_slope <- mean(species_slopes$slope)

h1plot_peak <- ggplot(dat.tests[[2]], aes(x = Year, y = doy, color = spClean, shape = genus))
h1plot_peak <- h1plot_peak + 
geom_point() + 
geom_smooth(method = 'lm', se= FALSE, linewidth=2) + 
 geom_abline(intercept = avg_intercept, slope = avg_slope, color = "black", linewidth = 5) +
theme_bw(base_size=18) +
    theme(legend.position = "none")  +
stat_poly_eq(
    aes(label = paste(after_stat(eq.label), after_stat(p.value.label), sep = "~~~")),
    formula = y ~ x, 
    parse = TRUE,
    label.y = 40
  ) +
labs(color = "Species", )
print(h1plot_peak)
summary(lm(doy ~ Year, data = dat.tests[[2]]))

# genus level 

dat.tests.acer_peak <- dat.tests$ph4.6[grep('Acer', dat.tests$ph4.6$spClean), ]
dat.tests.cercis_peak <- dat.tests$ph4.6[grep('Cercis', dat.tests$ph4.6$spClean), ]
dat.tests.cornus_peak <- dat.tests$ph4.6[grep('Cornus', dat.tests$ph4.6$spClean), ]
dat.tests.tilia_peak <- dat.tests$ph4.6[grep('Tilia', dat.tests$ph4.6$spClean), ]

## not sure if I should do this or facet_warp cause this allows me to move around arrangements and add viridus
## To-do need to add genus data frame
library(patchwork)
ACERplot_peak <- ggplot(dat.tests.acer_peak, aes(x = Year, y = doy, color = spClean))
ACERplot_peak <- ACERplot_peak + 
geom_point() + scale_color_viridis_d() +
geom_smooth(method = 'lm', se= FALSE, linewidth=2) + 
  geom_smooth(method = "lm", aes(group = 1), color = "black", se = FALSE , linewidth= 3) +
theme_bw(base_size=18) +
  theme(legend.position = "none") +
labs(title = "Trends Acer", y= "Day of Year", color = "Species", )
print(ACERplot_peak)

CERCISplot_peak <- ggplot(dat.tests.cercis_peak, aes(x = Year, y = doy, color = spClean))
CERCISplot_peak <- CERCISplot_peak + 
geom_point() + scale_color_viridis_d() +
geom_smooth(method = 'lm', se= FALSE, linewidth=2) + 
  geom_smooth(method = "lm", aes(group = 1), color = "black", se = FALSE , linewidth= 3) +
theme_bw(base_size=18) +
  theme(legend.position = "none") +
labs(title = "Trends Cercis", y= "Day of Year", color = "Species", )
print(CERCISplot_peak)

CORNUSplot_peak <- ggplot(dat.tests.cornus_peak, aes(x = Year, y = doy, color = spClean))
CORNUSplot_peak <- CORNUSplot_peak + 
geom_point() + scale_color_viridis_d() +
geom_smooth(method = 'lm', se= FALSE, linewidth=2) + 
  geom_smooth(method = "lm", aes(group = 1), color = "black", se = FALSE , linewidth= 3) +
theme_bw(base_size=18) +
    theme(legend.position = "none") +
labs(title = "Trends Cornus", y= "Day of Year", color = "Species", )
print(CORNUSplot_peak)

TILIAplot_peak <- ggplot(dat.tests.tilia_peak, aes(x = Year, y = doy, color = spClean))
TILIAplot_peak <- TILIAplot_peak + 
geom_point() + scale_color_viridis_d() +
geom_smooth(method = 'lm', se= FALSE, linewidth=2) + 
  geom_smooth(method = "lm", aes(group = 1), color = "black", se = FALSE , linewidth= 3) +
theme_bw(base_size=18) +
  theme(legend.position = "none") +
labs(title = "Trends Tilia", y= "Day of Year", color = "Species", )
print(TILIAplot_peak)



h1plot_peak | (ACERplot_peak + CERCISplot_peak + CORNUSplot_peak + TILIAplot_peak)

#Presentation graphs
dat.tests.tilia.cor_peak <- dat.tests$ph4.6[grep('Tilia cordata', dat.tests$ph4.6$spClean), ]
dat.tests.tilia.am_early <- dat.tests$ph1.3[grep('Tilia americana', dat.tests$ph1.3$spClean), ]
dat.tests.tilia.am_peak <- dat.tests$ph4.6[grep('Tilia americana', dat.tests$ph4.6$spClean), ]
dat.tests.tilia.am_late <- dat.tests$ph7.8[grep('Tilia americana', dat.tests$ph7.8$spClean), ]
dat.tests.acer.sac_peak <- dat.tests$ph4.6[grep('Acer saccharinum', dat.tests$ph4.6$spClean), ]
dat.tests.acer.plat_peak <- dat.tests$ph4.6[grep('Acer platanoides', dat.tests$ph4.6$spClean), ]
dat.tests.cornussan_peak <- dat.tests$ph4.6[grep('Cornus sanguinea', dat.tests$ph4.6$spClean), ]

dat.tests.tilia.am_early <- dat.tests.tilia.am_early %>% 
  add_row(DeterminationCalcFullName= "Tilia americana", Year = 2026, doy = 165)

dat.tests.tilia.am_peak <- dat.tests.tilia.am_peak %>% 
  add_row(DeterminationCalcFullName= "Tilia americana", Year = 2026, doy = 178)

dat.tests.tilia.am_late <- dat.tests.tilia.am_late %>% 
  add_row(DeterminationCalcFullName= "Tilia americana", Year = 2026, doy = 188)

TILIAcorplot_peak <- ggplot(dat.tests.tilia.cor_peak, aes(x = Year, y = doy))
TILIAcorplot_peak <- TILIAcorplot_peak + 
geom_point() + 
geom_smooth(method = 'lm', se= TRUE, linewidth=2) + 
theme_bw(base_size=20) +
stat_poly_eq(
    aes(label = paste(after_stat(eq.label), after_stat(p.value.label), sep = "~~~")),
    formula = y ~ x, 
    parse = TRUE,
    label.y = 40
  )
print(TILIAcorplot_peak)


CERCISplot_peak <- ggplot(dat.tests.cercis_peak, aes(x = Year, y = doy))
CERCISplot_peak <- CERCISplot_peak + 
geom_point() + 
geom_smooth(method = 'lm', se= TRUE, linewidth=2) + 
theme_bw(base_size=20)+
stat_poly_eq(
    aes(label = paste(after_stat(eq.label), after_stat(p.value.label), sep = "~~~")),
    formula = y ~ x, 
    parse = TRUE,
    label.y = 40)
print(CERCISplot_peak)


ACERplatplot_peak <- ggplot(dat.tests.acer.plat_peak, aes(x = Year, y = doy))
ACERplatplot_peak <- ACERplatplot_peak + 
geom_point() + scale_y_continuous(
    breaks = seq(from = 100, to = 160, by = 10), limits = c(100, 155)) + 
geom_smooth(method = 'lm', se= FALSE, linewidth=2) + 
theme_bw(base_size=20)
print(ACERplatplot_peak)

CORNUSsanplot_peak <- ggplot(dat.tests.cornussan_peak, aes(x = Year, y = doy))
CORNUSsanplot_peak <- CORNUSsanplot_peak + 
geom_point() + scale_y_continuous(
    breaks = seq(from = 150, to = 220, by = 10), limits = c(150, 220)) +
geom_smooth(method = 'lm', se= FALSE, linewidth=2) + 
theme_bw(base_size=20)
print(CORNUSsanplot_peak)


#Plots for Tilia am including phenology
TILIAamplot_early <- ggplot(dat.tests.tilia.am_early, aes(x = Year, y = doy))
TILIAamplot_early <- TILIAamplot_early + 
geom_point(aes(color = doy== "165")) + geom_vline(xintercept = 1970, color = "black", linewidth = 1) +
geom_smooth(method = 'lm', se= TRUE, linewidth=2) + 
theme_bw(base_size=20) +
  scale_color_manual(
    values = c("FALSE" = "purple", "TRUE" = "yellow"),
    labels = c("Herbarium Data", "2026 field estimate"),
    name = "Field work"
  ) +
stat_poly_eq(
    aes(label = paste(after_stat(eq.label), after_stat(p.value.label), sep = "~~~")),
    formula = y ~ x, 
    parse = TRUE,
    label.y = 40
  )
print(TILIAamplot_early)

TILIAamplot_peak <- ggplot(dat.tests.tilia.am_peak, aes(x = Year, y = doy))
TILIAamplot_peak <- TILIAamplot_peak + 
geom_point(aes(color = doy== "178")) + 
geom_smooth(method = 'lm', se= TRUE, linewidth=2) + 
theme_bw(base_size=20) +
  scale_color_manual(
    values = c("FALSE" = "purple", "TRUE" = "yellow"),
    labels = c("Herbarium Data", "2026 field estimate"),
    name = "Field work"
  ) +
stat_poly_eq(
    aes(label = paste(after_stat(eq.label), after_stat(p.value.label), sep = "~~~")),
    formula = y ~ x, 
    parse = TRUE,
    label.y = 40
  )
print(TILIAamplot_peak)

TILIAamplot_late <- ggplot(dat.tests.tilia.am_late, aes(x = Year, y = doy))
TILIAamplot_late <- TILIAamplot_late + 
geom_point(aes(color = doy== "188")) + 
geom_smooth(method = 'lm', se= TRUE, linewidth=2) + 
theme_bw(base_size=20) +
  scale_color_manual(
    values = c("FALSE" = "purple", "TRUE" = "yellow"),
    labels = c("Herbarium Data", "2026 field estimate"),
    name = "Field work"
  ) +
stat_poly_eq(
    aes(label = paste(after_stat(eq.label), after_stat(p.value.label), sep = "~~~")),
    formula = y ~ x, 
    parse = TRUE,
    label.y = 40
  )
print(TILIAamplot_late)



##My mom ask me to do...
#residuals_vector <- residuals(lmerTests_yr$peak)

#hist(residuals_vector, main = "Hist of Residuals", xlab = "Residuals", col = "blue")
#shapiro.test(residuals_vector)

