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



h1plot_peak <- ggplot(dat.tests[[2]], aes(x = Year, y = doy, color = spClean))
h1plot_peak <- h1plot_peak + 
geom_point() + 
geom_smooth(method = 'lm', se= FALSE, linewidth=2) + 
  geom_smooth(method = "lm", aes(group = 1), color = "black", se = FALSE , linewidth= 5) +
theme_bw(base_size=18) +
    theme(legend.position = "none") +
labs(title = "Peak Flowering by Year", subtitle= "Trends across four genera", y= "Day of Year", color = "Species", )
print(h1plot_peak)

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





##My mom ask me to do...
#residuals_vector <- residuals(lmerTests_yr$peak)

#hist(residuals_vector, main = "Hist of Residuals", xlab = "Residuals", col = "blue")
#shapiro.test(residuals_vector)

