library(ggplot2)
library(dplyr)
library(readr)

# Function to read data and create a column indicating the source
read_and_label <- function(file_path, label) {
  data <- read_csv(file_path)
  data$source <- label
  return(data)
}

# Function to plot density, normalized density and histogram
plot_figures <- function(data, position_col, fold_change_col, cell_type) {
  plot1 <- ggplot(data, aes_string(x = position_col, color = 'source')) +
    geom_density() +
    labs(title = paste("Density Plot -", cell_type),
         x = "Position", y = "Density") +
    theme_minimal() +
    scale_color_discrete(name = "Legend", labels = c("YY1_all", "YY1_TAF1_com"))
  print(plot1)
  
  plot2 <- ggplot(data, aes_string(x = position_col, color = 'source', group = 'source')) +
    geom_density(aes(y = ..count../sum(..count..))) +
    labs(title = paste("Normalized Density Plot -", cell_type),
         x = "Position", y = "Normalized Density") +
    theme_minimal() +
    scale_color_discrete(name = "Legend", labels = c("YY1_all", "YY1_TAF1_com"))
  print(plot2)
  
  x_upper_limit <- quantile(data[[fold_change_col]], 0.99, na.rm = TRUE)
  
  plot3 <- ggplot(data, aes_string(x = fold_change_col, fill = 'source')) +
    geom_histogram(position = "dodge", binwidth = 3) + # changed binwidth to 3
    labs(title = paste("Histogram -", cell_type),
         x = "Tag Fold Change", y = "Count") +
    theme_minimal() +
    scale_fill_discrete(name = "Legend", labels = c("YY1_all", "YY1_TAF1_com")) +
    scale_x_continuous(breaks = seq(0, x_upper_limit, by = 10), limits = c(0, x_upper_limit))
  print(plot3)
  
  plot4 <- ggplot(data, aes_string(x = fold_change_col, y = '..count..', color = 'source')) +
    stat_density(aes(y = ..count..), geom = "line", adjust = 1) +
    labs(title = paste("Smooth Line Plot for Count -", cell_type),
         x = "Tag Fold Change", y = "Count") +
    theme_minimal() +
    scale_color_discrete(name = "Legend", labels = c("YY1_all", "YY1_TAF1_com")) +
    scale_x_continuous(limits = c(0, x_upper_limit))
  print(plot4)
  
}

# List of file paths and labels
file_labels <- list(
  c("./SK-N-SH/Peak_list_all_YY1_SK-N-SH.csv", "YY1_all", "SK-N-SH"),
  c("./SK-N-SH/Peak_list_YY1_TAF1_com_SK-N-SH.csv", "YY1_TAF1_com", "SK-N-SH"),
  c("./H1-hESC/Peak_list_all_YY1_H1-hESC.csv", "YY1_all", "H1-hESC"),
  c("./H1-hESC/Peak_list_YY1_TAF1_com_H1-hESC.csv", "YY1_TAF1_com", "H1-hESC"),
  c("./GM12878/Peak_list_all_YY1_GM12878.csv", "YY1_all", "GM12878"),
  c("./GM12878/Peak_list_YY1_TAF1_com_GM12878.csv", "YY1_TAF1_com", "GM12878")
)

# Assuming 'position' and 'tag_fold_change' are column names in your data, replace with actual column names if different
position_col <- "position"
fold_change_col <- "tag_fold_change"

# Loop through file-label pairs, read data, bind and plot figures
for (i in seq(1, length(file_labels), by = 2)) {
  data1 <- read_and_label(file_labels[[i]][1], file_labels[[i]][2])
  data2 <- read_and_label(file_labels[[i+1]][1], file_labels[[i+1]][2])
  
  all_data <- bind_rows(data1, data2)
  
  # Assuming 'start' and 'end' are column names in your data, replace with actual column names if different
  all_data$position <- (all_data$start + all_data$end) / 2
  
  cell_type <- file_labels[[i]][3]
  
  plot_figures(all_data, position_col, fold_change_col, cell_type)
}


