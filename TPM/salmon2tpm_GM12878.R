# Libraries
## Data Import and Manipulation
library(tximport)
library(biomaRt)
library(dplyr)
library(tidyr)
library(readr)

## Visualization
library(ggplot2)
library(scales)

## Statistical Analysis
library(stats)

# Assigning the files to a list
files_GM12878 <- c("salmon_out_GM12878/salmon_output_ENCLB040ZZZ/quant.sf",
                   "salmon_out_GM12878/salmon_output_ENCLB039ZZZ/quant.sf")

# Importing the data using tximport
txi_GM12878 <- tximport(files_GM12878, type = "salmon", txOut = TRUE)

# Extracting TPM directly
tpm_GM12878 <- txi_GM12878$abundance

# Convert matrices to data frames
tpm_GM12878 <- as.data.frame(tpm_GM12878)

# Now we will get the ensemble annotation to convert to gene symbols
ensembl <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")

# Getting the gene annotation
transcripts <- getBM(attributes = c("ensembl_transcript_id_version", "external_gene_name"), mart = ensembl)

# Combine several steps together using the %>% operator
final_tpm_GM12878 <- tpm_GM12878 %>%
  mutate(gene_symbol = sub("\\..*", "", transcripts$external_gene_name[match(rownames(.), transcripts$ensembl_transcript_id_version)])) %>%
  filter(!(rowSums(.[, -ncol(.)]) == 0 | is.na(gene_symbol))) %>%
  group_by(gene_symbol) %>%
  summarize(across(everything(), sum))

# 1. Read in Gene Lists
GM12878_YY1_TAF1 <- read_tsv("GM12878_YY1_TAF1_com_genes_list.tsv")
GM12878_TAF1 <- read_tsv("MM1_HSA_GM12878_TAF1_exclu_genes_list.tsv")
GM12878_YY1 <- read_tsv("MM1_HSA_GM12878_YY1_exclu_genes_list.tsv")

# 2. Subset TPM Data
subset_GM12878_YY1_TAF1 <- final_tpm_GM12878[final_tpm_GM12878$gene_symbol %in% GM12878_YY1_TAF1[[1]], ]
subset_GM12878_TAF1 <- final_tpm_GM12878[final_tpm_GM12878$gene_symbol %in% GM12878_TAF1[[1]], ]
subset_GM12878_YY1 <- final_tpm_GM12878[final_tpm_GM12878$gene_symbol %in% GM12878_YY1[[1]], ]

# Reshape Data for plotting
df_for_plot <- bind_rows(
  mutate(subset_GM12878_YY1_TAF1, gene_list = "GM12878_YY1_TAF1_com"),
  mutate(subset_GM12878_TAF1, gene_list = "GM12878_TAF1_exclu"),
  mutate(subset_GM12878_YY1, gene_list = "GM12878_YY1_exclu")
)

# Calculate average expression for each gene set
df_for_plot$avg_expression <- rowMeans(df_for_plot[, -c(1, ncol(df_for_plot))], na.rm=TRUE)

# Statistical Analysis
result.aov <- aov(avg_expression ~ gene_list, data = df_for_plot)
summary(result.aov)
pairwise <- TukeyHSD(result.aov, "gene_list")

print(pairwise)

# Determine the y-coordinates for the new lines
ymax <- max(df_for_plot$avg_expression, na.rm = TRUE)
y_start <- 10^(log10(ymax) + 0.1)
y_end <- y_start + 0.1 * y_start

# y_start1 <- y_end + 0.2 * y_start
# y_end1 <- y_start1 + 0.1 * y_start1
# 
# y_start2 <- y_end1 + 0.2 * y_start1
# y_end2 <- y_start2 + 0.1 * y_start2

# Plotting with a logarithmic y-axis
p <- ggplot(df_for_plot, aes(x = gene_list, y = avg_expression)) +
  geom_boxplot(aes(fill = gene_list), outlier.shape = 1, outlier.color = "black") +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_fill_manual(values = c("GM12878_YY1_TAF1_com" = "blue", "GM12878_TAF1_exclu" = "red", "GM12878_YY1_exclu" = "green")) +
  theme_minimal() +
  labs(title = "TPM Distribution across Gene Groups related to YY1 and/or TAF1",
       x = "Gene Group",
       y = "Average TPM (Log Scale)",
       fill = "Gene List") +
  theme(legend.position = "none") +
  
  # Add the horizontal line for significance less than 0.01 p_adj
  geom_segment(aes(x = 2, xend = 3, y = y_end, yend = y_end), linetype = "dashed", color = "black") +
  geom_text(aes(x = 2.5, y = y_end * 1.1, label = "**"), size = 5)
  
  # # Add the new horizontal line from GM12878_YY1_exclu to GM12878_TAF1_exclu
  # geom_segment(aes(x = 1, xend = 2, y = y_end1, yend = y_end1), linetype = "dashed", color = "black") +
  # geom_text(aes(x = 1.5, y = y_end1 * 1.1, label = "*"), size = 5) +
  # 
  # # Add another horizontal line from GM12878_YY1_TAF1_com to GM12878_TAF1_exclu
  # geom_segment(aes(x = 3, xend = 1, y = y_end2, yend = y_end2), linetype = "dashed", color = "black") +
  # geom_text(aes(x = 2, y = y_end2 * 1.1, label = "*"), size = 5)

# Display the plot
print(p)

# Calculate statistical summaries for original data subsets
summarize_subset <- function(df) {
  summarised_df <- summarise(df,
                             num_genes = n(),
                             avg_expression = mean(rowMeans(df[, -1], na.rm = TRUE), na.rm = TRUE),
                             median_expression = median(rowMeans(df[, -1], na.rm = TRUE), na.rm = TRUE),
                             std_dev = sd(rowMeans(df[, -1], na.rm = TRUE), na.rm = TRUE),
                             min_expression = min(rowMeans(df[, -1], na.rm = TRUE), na.rm = TRUE),
                             max_expression = max(rowMeans(df[, -1], na.rm = TRUE), na.rm = TRUE)
  )
  return(summarised_df)
}

# Generate statistical summary for each subset
summary_GM12878_YY1_TAF1 <- summarize_subset(subset_GM12878_YY1_TAF1)
summary_GM12878_TAF1 <- summarize_subset(subset_GM12878_TAF1)
summary_GM12878_YY1 <- summarize_subset(subset_GM12878_YY1)

# Combine the summaries into a single data frame
group_summary <- bind_rows(
  mutate(summary_GM12878_YY1_TAF1, gene_list = "H1-hESC_YY1_TAF1_com"),
  mutate(summary_GM12878_TAF1, gene_list = "H1-hESC_TAF1_exclu"),
  mutate(summary_GM12878_YY1, gene_list = "H1-hESC_YY1_exclu")
)

# Display the summary data frame
print(group_summary)
