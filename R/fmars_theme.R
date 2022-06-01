#fmars_theme.R
#author: "Mike Connelly"
#date: "03/22/2022"

# Create ggplot2 theme for journal submission
# Frontiers in Marine Science figure guidelines
# Individual figures should not be longer than one page and with a width that corresponds to 1 column (85 mm) or 2 columns (180 mm).
# 
theme_fmars <- function(base_size = 10) {
  (theme_foundation(base_size=base_size)
   + theme(
     # 
     plot.background = element_rect(colour = NA),
     panel.background = element_blank(),
     panel.grid.major = element_blank(), 
     panel.grid.minor = element_blank(), 
     panel.border = element_rect(color = "black", fill = NA),
     # 
     plot.title = element_text(face = "plain", size = rel(1.2), hjust = 0),
     plot.subtitle = element_text(face = "plain", size = rel(0.8)),
     # 
     axis.title = element_text(face = "plain",size = rel(1)),
     axis.title.x = element_text(vjust = 0),
     axis.title.y = element_text(angle = 90, vjust = 2),
     text = element_text(),
     axis.text = element_text(size = rel(0.8)), 
     axis.text.x = element_text(angle = 0),
     axis.text.y = element_text(), 
     #axis.line = element_line(colour = "black"),
     axis.ticks = element_line(),
     # 
     legend.title = element_text(size = rel(1)),
     legend.text = element_text(size = rel(0.8), margin = margin(t = 2, b = 2, unit = "mm")),
     legend.key = element_rect(color = NA),
     legend.background = element_rect(fill = NA, colour = NA),
     legend.position = "right",
     legend.direction = "vertical",
     legend.spacing.x = unit(2, "mm"),
     legend.spacing.y = unit(0, "mm"),
     legend.key.size = unit(2, "mm"),
     # 
     plot.margin = unit(c(2,2,2,2), "mm"),
     # 
     strip.background = element_rect(color = "black", fill = "grey"),
     strip.text = element_text(size = rel(1), face = "plain")
   ))
}
###

# Ocean Science Meeting 2022 poster theme
theme_osm22 <- function(base_size = 10) {
   (theme_foundation(base_size=base_size)
    + theme(
       # 
      plot.title = element_text(size = 28),
      axis.title = element_text(size = 24),
      axis.text = element_blank(),
      legend.title = element_text(size = 24),
      legend.text = element_text(size = 20)
    ))
}
