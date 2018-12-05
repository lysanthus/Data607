NYMap <- function(df, x, title = NULL, sub = NULL, leg = NULL){
  suppressMessages(library(maps))
  suppressMessages(library(RColorBrewer))
  mapData <- map_data("county","new york")
  
  mapped <- inner_join(mapData, df, by = c("subregion" = "county"))
  
  ggplot() +
    geom_polygon(data = mapped, 
                 aes(x=long, y = lat, 
                     group = group,
                     fill = cut(as.numeric(mapped[[x]]),
                                breaks=c(0, seq(25,250,by=25)))), 
                 col = "black") + 
    scale_fill_brewer(leg, palette = "RdYlGn"
                      ,direction = -1) +
    coord_fixed(1.3) +
    theme(panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(),
          panel.background = element_blank(), 
          axis.line = element_blank(),
          axis.text = element_blank(),
          axis.title = element_blank(),
          axis.ticks = element_blank()) +
    ggtitle(title,sub)
}