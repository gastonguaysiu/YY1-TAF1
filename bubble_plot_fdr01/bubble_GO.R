# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Read the TSV data for each file
taf1_exclu <- read.table("gm12878_promo_taf1_exclu_yy1_GO_fdr01.tsv", header=TRUE, sep="\t") %>%
  mutate(Source = "taf1_exclu")

yy1_com_taf1 <- read.table("gm12878_promo_yy1_com_taf1_GO_fdr01.tsv", header=TRUE, sep="\t") %>%
  mutate(Source = "yy1_com_taf1")

yy1_exclu <- read.table("gm12878_promo_yy1_exclu_taf1_GO_fdr01.tsv", header=TRUE, sep="\t") %>%
  mutate(Source = "yy1_exclu")

# Combine the three data frames into one
combined_data <- bind_rows(taf1_exclu, yy1_com_taf1, yy1_exclu)

# Transform FDR to get -log(FDR) with a lower cap of 1e-10
combined_data <- combined_data %>%
  mutate(FDR = pmax(FDR, 1e-10),
         neg_log_FDR = -log10(FDR))

# Ordering 'term' and 'Term_desc' based on 'Source' and 'FDR'
combined_data <- combined_data %>%
  arrange(Source, FDR) %>%
  mutate(
    term = factor(term, levels = unique(term)),
    Term_desc = factor(Term_desc, levels = unique(Term_desc))
  )

# Create the bubble plot
bubble_plot <- ggplot(combined_data, aes(x = Source, y = Term_desc, size = neg_log_FDR, color = Category)) +
  geom_point(alpha=0.6) +
  scale_color_manual(values = c("blue", "red", "green")) +  # Manually set the colors for the categories
  theme_light() +
  labs(title = "GM12878 promoter-TSS peak GOs", 
       size = "-log FDR",
       color = "Category",
       y = "GO Term",
       x = "Data Source") +
  theme(legend.position = "right")

print(bubble_plot)

###

# Read the TSV data for each file
taf1_exclu <- read.table("h1_hesc_promo_taf1_exclu_yy1_GO_fdr01.tsv", header=TRUE, sep="\t") %>%
  mutate(Source = "taf1_exclu")

yy1_com_taf1 <- read.table("h1_hesc_promo_yy1_com_taf1_GO_fdr01.tsv", header=TRUE, sep="\t") %>%
  mutate(Source = "yy1_com_taf1")

yy1_exclu <- read.table("h1_hesc_promo_yy1_exclu_taf1_GO_fdr01.tsv", header=TRUE, sep="\t") %>%
  mutate(Source = "yy1_exclu")

# Combine the three data frames into one
combined_data <- bind_rows(taf1_exclu, yy1_com_taf1, yy1_exclu)

# Transform FDR to get -log(FDR) with a lower cap of 1e-10
combined_data <- combined_data %>%
  mutate(FDR = pmax(FDR, 1e-10),
         neg_log_FDR = -log10(FDR))

# Ordering 'term' and 'Term_desc' based on 'Source' and 'FDR'
combined_data <- combined_data %>%
  arrange(Source, FDR) %>%
  mutate(
    term = factor(term, levels = unique(term)),
    Term_desc = factor(Term_desc, levels = unique(Term_desc))
  )

# Create the bubble plot
bubble_plot <- ggplot(combined_data, aes(x = Source, y = Term_desc, size = neg_log_FDR, color = Category)) +
  geom_point(alpha=0.6) +
  scale_color_manual(values = c("blue", "red", "green")) +  # Manually set the colors for the categories
  theme_light() +
  labs(title = "H1 hESC promoter-TSS peak GOs", 
       size = "-log FDR",
       color = "Category",
       y = "GO Term",
       x = "Data Source") +
  theme(legend.position = "right")

print(bubble_plot)


###


# Read the TSV data for each file
taf1_exclu <- read.table("h1_hesc_promo_taf1_exclu_yy1_GO_fdr01.tsv", header=TRUE, sep="\t") %>%
  mutate(Source = "taf1_exclu")

yy1_com_taf1 <- read.table("h1_hesc_promo_yy1_com_taf1_GO_fdr01.tsv", header=TRUE, sep="\t") %>%
  mutate(Source = "yy1_com_taf1")

yy1_exclu <- read.table("h1_hesc_promo_yy1_exclu_taf1_GO_fdr01.tsv", header=TRUE, sep="\t") %>%
  mutate(Source = "yy1_exclu")

# Combine the three data frames into one
combined_data <- bind_rows(taf1_exclu, yy1_com_taf1, yy1_exclu)

# Transform FDR to get -log(FDR) with a lower cap of 1e-10
combined_data <- combined_data %>%
  mutate(FDR = pmax(FDR, 1e-10),
         neg_log_FDR = -log10(FDR))

# Ordering 'term' and 'Term_desc' based on 'Source' and 'FDR'
combined_data <- combined_data %>%
  arrange(Source, FDR) %>%
  mutate(
    term = factor(term, levels = unique(term)),
    Term_desc = factor(Term_desc, levels = unique(Term_desc))
  )

# Create the bubble plot
bubble_plot <- ggplot(combined_data, aes(x = Source, y = Term_desc, size = neg_log_FDR, color = Category)) +
  geom_point(alpha=0.6) +
  scale_color_manual(values = c("blue", "red", "green")) +  # Manually set the colors for the categories
  theme_light() +
  labs(title = "H1 hESC promoter-TSS peak GOs", 
       size = "-log FDR",
       color = "Category",
       y = "GO Term",
       x = "Data Source") +
  theme(legend.position = "right")

print(bubble_plot)

###


# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Read the TSV data for each file
taf1_exclu <- read.table("sk_n_sh_promo_taf1_exclu_yy1_GO_fdr01.tsv", header=TRUE, sep="\t") %>%
  mutate(Source = "taf1_exclu")

yy1_com_taf1 <- read.table("sk_n_sh_promo_yy1_com_taf1_GO_fdr01.tsv", header=TRUE, sep="\t") %>%
  mutate(Source = "yy1_com_taf1")

yy1_exclu <- read.table("sk_n_sh_promo_yy1_exclu_taf1_GO_fdr01.tsv", header=TRUE, sep="\t") %>%
  mutate(Source = "yy1_exclu")

# Combine the three data frames into one
combined_data <- bind_rows(taf1_exclu, yy1_com_taf1, yy1_exclu)

# Transform FDR to get -log(FDR) with a lower cap of 1e-10
combined_data <- combined_data %>%
  mutate(FDR = pmax(FDR, 1e-10),
         neg_log_FDR = -log10(FDR))

# Ordering 'term' and 'Term_desc' based on 'Source' and 'FDR'
combined_data <- combined_data %>%
  arrange(Source, FDR) %>%
  mutate(
    term = factor(term, levels = unique(term)),
    Term_desc = factor(Term_desc, levels = unique(Term_desc))
  )

# Create the bubble plot
bubble_plot <- ggplot(combined_data, aes(x = Source, y = Term_desc, size = neg_log_FDR, color = Category)) +
  geom_point(alpha=0.6) +
  scale_color_manual(values = c("blue", "red", "green")) +  # Manually set the colors for the categories
  theme_light() +
  labs(title = "SK-N-SH promoter-TSS peak GOs", 
       size = "-log FDR",
       color = "Category",
       y = "GO Term",
       x = "Data Source") +
  theme(legend.position = "right")

print(bubble_plot)
