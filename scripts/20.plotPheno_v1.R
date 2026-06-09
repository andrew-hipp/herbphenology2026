plotDat.til_am <- phenoPh.til_am[phenoPh.til_am$Phenophase %in% 4:6,]
p <- ggplot(plotDat.til_am, aes(x = Year, y = doy))
p <- p + geom_point() + geom_smooth(method = 'lm')
ggsave('out/tilam_YvDOY.pdf')
