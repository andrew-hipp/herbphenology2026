
# Acer trendline for peak flowering
plotDat.acer <- phenoPh.acer[phenoPh.acer$Phenophase %in% 4:6,]
plotDat.acer$Phenophase <- factor(plotDat.acer$Phenophase)
p <- ggplot(plotDat.acer, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
print(p)
ggsave('out/acer_YvDOY.pdf')

# Acer trendline for all phases
plotDat.acer <- phenoPh.acer[phenoPh.acer$Phenophase %in% 1:9,]
plotDat.acer$Phenophase <- factor(plotDat.acer$Phenophase)
p <- ggplot(plotDat.acer, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
print(p)
ggsave('out/acer_allDOY.pdf')

# Acer trendline updated to not include seed only
plotDat.acer <- phenoPh.acer[phenoPh.acer$Phenophase %in% 1:8,]
plotDat.acer$Phenophase <- factor(plotDat.acer$Phenophase)
p <- ggplot(plotDat.acer, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
print(p)
ggsave('out/acer_betterDOY.pdf')

# Acer trendline flower opening (1-3)
plotDat.acer <- phenoPh.acer[phenoPh.acer$Phenophase %in% 1:3,]
plotDat.acer$Phenophase <- factor(plotDat.acer$Phenophase)
p <- ggplot(plotDat.acer, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
print(p)
ggsave('out/acer_betterDOY.pdf')

# Acer trendline peak (4-6)
plotDat.acer <- phenoPh.acer[phenoPh.acer$Phenophase %in% 4:6,]
plotDat.acer$Phenophase <- factor(plotDat.acer$Phenophase)
p <- ggplot(plotDat.acer, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
print(p)
ggsave('out/acer_betterDOY.pdf')

# Acer trendline flower ending (7-8)
plotDat.acer <- phenoPh.acer[phenoPh.acer$Phenophase %in% 7:8,]
plotDat.acer$Phenophase <- factor(plotDat.acer$Phenophase)
p <- ggplot(plotDat.acer, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
print(p)
ggsave('out/acer_betterDOY.pdf')

#Trend is as predicted without seeds. Trend was likely positive because of higher sampling in later years
# Should explore other colors
# Next steps- separate by species, fix the scale to include all values (talk to Dr. Pearson), look into the seed trend and outliers, 