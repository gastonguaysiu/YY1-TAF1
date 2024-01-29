# Load required libraries
library(ggplot2)
library(dplyr)

# Read the TSV data
data <- read.table("gm12878_promo_yy1_com_taf1_GO.tsv", header=TRUE, sep="\t")

# Ordering 'term' and 'Term_desc' based on 'Category' and 'PValue'
data <- data %>% 
  arrange(Category, PValue) %>%
  mutate(term = factor(term, levels = unique(term)),
         Term_desc = factor(Term_desc, levels = unique(Term_desc)))

# Bubble plot with 'term' on the y-axis
p1 <- ggplot(data, aes(x = Category, y = term, size = as.numeric(X.), color = as.numeric(PValue))) +
  geom_point(alpha=0.6) +
  scale_color_gradient(low="blue", high="red", trans="log10") +
  theme_light() +
  labs(title = "GM12878 YY1-TAF1 co-bound peaks -> genes -> GO", 
       size = "gene count ratio in %",
       color = "PValue (log scale)") +
  theme(legend.position = "right")
print(p1)

# Bubble plot with 'Term_desc' on the y-axis
p2 <- ggplot(data, aes(x = Category, y = Term_desc, size = as.numeric(X.), color = as.numeric(PValue))) +
  geom_point(alpha=0.6) +
  scale_color_gradient(low="blue", high="red", trans="log10") +
  theme_light() +
  labs(title = "GM12878 YY1-TAF1 co-bound promoter-TSS peaks -> genes -> GO", 
       size = "gene count ratio in %",
       color = "PValue (log scale)") +
  theme(legend.position = "right")
print(p2)




# Load required libraries
library(ggplot2)
library(dplyr)

# Read the TSV data
data <- read.table("gm12878_promo_yy1_com_taf1_GO.tsv", header=TRUE, sep="\t")

# Filtering for FDR < 0.05 and ordering 'term' and 'Term_desc' based on 'Category' and 'FDR'
data <- data %>% 
  filter(FDR < 0.05) %>%
  arrange(Category, FDR) %>%
  mutate(term = factor(term, levels = unique(term)),
         Term_desc = factor(Term_desc, levels = unique(Term_desc)))

# Bubble plot with 'term' on the y-axis
p1 <- ggplot(data, aes(x = Category, y = term, size = as.numeric(X.), color = as.numeric(FDR))) +
  geom_point(alpha=0.6) +
  scale_color_gradient(low="blue", high="red", trans="log10") +
  theme_light() +
  labs(title = "GM12878 YY1-TAF1 co-bound peaks -> genes -> GO", 
       size = "gene count ratio in %",
       color = "FDR (log scale)") +
  theme(legend.position = "right")
print(p1)

# Bubble plot with 'Term_desc' on the y-axis
p2 <- ggplot(data, aes(x = Category, y = Term_desc, size = as.numeric(X.), color = as.numeric(FDR))) +
  geom_point(alpha=0.6) +
  scale_color_gradient(low="blue", high="red", trans="log10") +
  theme_light() +
  labs(title = "GM12878 YY1-TAF1 co-bound promoter-TSS peaks -> genes -> GO", 
       size = "gene count ratio in %",
       color = "FDR (log scale)") +
  theme(legend.position = "right")
print(p2)






# Save the plot
ggsave("bubble_plot_term_desc.png", plot = p2)
