
library(hrbrthemes)
library(GGally)
library(viridis)

colnames(chao_summary)

grab_cols <- c(42, 43,44,45,53,61)
parallel_plot_data <- chao_summary_ided[,grab_cols]
dim(parallel_plot_data)
#View(parallel_plot_data)
class(parallel_plot_data$source_class)
parallel_plot_data$source_class <- as.factor(as.integer(parallel_plot_data$source_class))

# Plot
ggparcoord(parallel_plot_data,
           columns = 1:5, groupColumn = 6
) 

parallel_plot <- ggparcoord(parallel_plot_data,
           columns = 1:5, groupColumn = 6, order = "anyClass",
           showPoints = TRUE, 
           title = "Parallel Coordinate Plot for the Feature Data",
           alphaLines = 0.3) + 
  scale_color_viridis(discrete=TRUE) +
  theme_ipsum()+
  theme(
    plot.title = element_text(size=10)
  )

parallel_plot
chaoetal_ided_parallel_plot <- paste(chao_graphics,"/chao_all_ided_parallel_plot.jpg",sep="")
jpeg(chaoetal_ided_parallel_plot, width = 12, height = 7, units = "in",res=600)
  parallel_plot
dev.off()
