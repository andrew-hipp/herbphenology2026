
# Tilia americana trendline for peak flowering
plotDat.til_am <- phenoPh.til_am[phenoPh.til_am$Phenophase %in% 4:6,]
plotDat.til_am$Phenophase <- factor(plotDat.til_am$Phenophase)
p <- ggplot(plotDat.til_am, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
ggsave('out/tilam_YvDOY.pdf')

# Tilia americana trendline for all phases
plotDat.til_am <- phenoPh.til_am[phenoPh.til_am$Phenophase %in% 1:9,]
plotDat.til_am$Phenophase <- factor(plotDat.til_am$Phenophase)
p <- ggplot(plotDat.til_am, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
ggsave('out/tilam_allDOY.pdf')

# Tilia americana trendline updated to not include seed only
plotDat.til_am <- phenoPh.til_am[phenoPh.til_am$Phenophase %in% 1:8,]
plotDat.til_am$Phenophase <- factor(plotDat.til_am$Phenophase)
p <- ggplot(plotDat.til_am, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
ggsave('out/til_am_betterDOY.pdf')
# Not enough points

#split up by 1-3, 4-6, 7-8 by genera and species. Only include species with ? or more