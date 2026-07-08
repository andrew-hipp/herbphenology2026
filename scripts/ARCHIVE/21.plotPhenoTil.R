
# All other Tilia trendline for peak flowering
plotDat.til <- phenoPh.til[phenoPh.til$Phenophase %in% 4:6,]
plotDat.til$Phenophase <- factor(plotDat.til$Phenophase)
p <- ggplot(plotDat.til, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
ggsave('out/til_YvDOY.pdf')

# All other Tilia trendline for all phases
plotDat.til <- phenoPh.til[phenoPh.til$Phenophase %in% 1:9,]
plotDat.til$Phenophase <- factor(plotDat.til$Phenophase)
p <- ggplot(plotDat.til, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
ggsave('out/til_allDOY.pdf')

# All other Tilia trendline updated to not include seed only
plotDat.til <- phenoPh.til[phenoPh.til$Phenophase %in% 1:8,]
plotDat.til$Phenophase <- factor(plotDat.til$Phenophase)
p <- ggplot(plotDat.til, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
ggsave('out/til_betterDOY.pdf')

# Tilia trendline flower opening (1-3)
plotDat.til <- phenoPh.til[phenoPh.til$Phenophase %in% 1:3,]
plotDat.til$Phenophase <- factor(plotDat.til$Phenophase)
p <- ggplot(plotDat.til, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
ggsave('out/til_betterDOY.pdf')

# Tilia trendline peak (4-6)
plotDat.til <- phenoPh.til[phenoPh.til$Phenophase %in% 4:6,]
plotDat.til$Phenophase <- factor(plotDat.til$Phenophase)
p <- ggplot(plotDat.til, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
ggsave('out/til_betterDOY.pdf')

# Tilia trendline flower ending (7-8)
plotDat.til <- phenoPh.til[phenoPh.til$Phenophase %in% 7:8,]
plotDat.til$Phenophase <- factor(plotDat.til$Phenophase)
p <- ggplot(plotDat.til, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
ggsave('out/til_betterDOY.pdf')
