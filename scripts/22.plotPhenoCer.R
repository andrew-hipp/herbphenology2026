
# Cercis trendline for peak flowering
plotDat.cer <- phenoPh.cer[phenoPh.cer$Phenophase %in% 4:6,]
plotDat.cer$Phenophase <- factor(plotDat.cer$Phenophase)
p <- ggplot(plotDat.cer, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
ggsave('out/cer_YvDOY.pdf')

# Cercis trendline for all phases
plotDat.cer <- phenoPh.cer[phenoPh.cer$Phenophase %in% 1:9,]
plotDat.cer$Phenophase <- factor(plotDat.cer$Phenophase)
p <- ggplot(plotDat.cer, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
ggsave('out/cer_allDOY.pdf')

# Cercis trendline updated to not include seed only
plotDat.cer <- phenoPh.cer[phenoPh.cer$Phenophase %in% 1:8,]
plotDat.cer$Phenophase <- factor(plotDat.cer$Phenophase)
p <- ggplot(plotDat.cer, aes(x = Year, y = doy, color= Phenophase))
p <- p + geom_point() + scale_color_viridis_d() + geom_smooth(aes(group = 1), method = 'lm', color= "black", se= FALSE) 
ggsave('out/cer_betterDOY.pdf')
