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
files_H1_hESC <- c("salmon_out_H1_hESC/salmon_output_ENCLB029TLD/quant.sf",
                   "salmon_out_H1_hESC/salmon_output_ENCLB824TWV/quant.sf",
                   "salmon_out_H1_hESC/salmon_output_ENCLB919QDK/quant.sf")

# Importing the data using tximport
txi_H1_hESC <- tximport(files_H1_hESC, type = "salmon", txOut = TRUE)

# Extracting TPM directly
tpm_H1_hESC <- txi_H1_hESC$abundance

# Convert matrices to data frames
tpm_H1_hESC <- as.data.frame(tpm_H1_hESC)

# Now we will get the ensemble annotation to convert to gene symbols
ensembl <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")

# Getting the gene annotation
transcripts <- getBM(attributes = c("ensembl_transcript_id_version", "external_gene_name"), mart = ensembl)

# Combine several steps together using the %>% operator
final_tpm_H1_hESC <- tpm_H1_hESC %>%
  mutate(gene_symbol = sub("\\..*", "", transcripts$external_gene_name[match(rownames(.), transcripts$ensembl_transcript_id_version)])) %>%
  filter(!(rowSums(.[, -ncol(.)]) == 0 | is.na(gene_symbol))) %>%
  group_by(gene_symbol) %>%
  summarize(across(everything(), sum))


# 1. Read in Gene Lists
H1_hESC_YY1_TAF1 <- read_tsv("H1-hESC_YY1_TAF1_com_genes_list.tsv")
H1_hESC_TAF1 <- read_tsv("MM1_HSA_H1-hESC_TAF1_exclu_genes_list.tsv")
H1_hESC_YY1 <- read_tsv("MM1_HSA_H1-hESC_YY1_exclu_genes_list.tsv")

# Assuming the gene lists are just single columns of gene names
# If they have headers, adjust column indexing accordingly

# 2. Subset TPM Data
subset_H1_hESC_YY1_TAF1 <- final_tpm_H1_hESC[final_tpm_H1_hESC$gene_symbol %in% H1_hESC_YY1_TAF1[[1]], ]
subset_H1_hESC_TAF1 <- final_tpm_H1_hESC[final_tpm_H1_hESC$gene_symbol %in% H1_hESC_TAF1[[1]], ]
subset_H1_hESC_YY1 <- final_tpm_H1_hESC[final_tpm_H1_hESC$gene_symbol %in% H1_hESC_YY1[[1]], ]

# Reshape Data for plotting
df_for_plot <- bind_rows(
  mutate(subset_H1_hESC_YY1_TAF1, gene_list = "H1-hESC_YY1_TAF1_com"),
  mutate(subset_H1_hESC_TAF1, gene_list = "H1-hESC_TAF1_exclu"),
  mutate(subset_H1_hESC_YY1, gene_list = "H1-hESC_YY1_exclu")
)

# Calculate average expression for each gene set
df_for_plot$avg_expression <- rowMeans(df_for_plot[, -c(1, ncol(df_for_plot))], na.rm=TRUE)

# Statistical Analysis
result.aov <- aov(avg_expression ~ gene_list, data = df_for_plot)
summary(result.aov)
pairwise <- TukeyHSD(result.aov, "gene_list")

print(pairwise)

# Determine the y-coordinate for the line
ymax <- max(subset(df_for_plot, gene_list %in% c("H1-hESC_YY1_TAF1_com", "H1-hESC_YY1_exclu"))$avg_expression, na.rm = TRUE)
y_start <- 10^(log10(ymax) + 0.1)
y_end <- y_start + 0.1 * y_start


# Plotting with a logarithmic y-axis
p <- ggplot(df_for_plot, aes(x = gene_list, y = avg_expression)) +
  geom_boxplot(aes(fill = gene_list), outlier.shape = 1, outlier.color = "black") +  # Boxplot with outlier points
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_fill_manual(values = c("H1-hESC_YY1_TAF1_com" = "blue", "H1-hESC_TAF1_exclu" = "red", "H1-hESC_YY1_exclu" = "green")) +
  theme_minimal() +
  labs(title = "TPM Distribution across Gene Groups for transcription factors",
       x = "Gene Group",
       y = "Average TPM (Log Scale)",
       fill = "Gene List") +
  theme(legend.position = "none") +
  
  # Add the horizontal line
  geom_segment(aes(x = 2, xend = 3, y = y_end, yend = y_end), linetype = "dashed", color = "black") +
  
  # Add the asterisk above the line
  geom_text(aes(x = 2.5, y = y_end * 1.1, label = "*"), size = 5)

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
summary_H1_hESC_YY1_TAF1 <- summarize_subset(subset_H1_hESC_YY1_TAF1)
summary_H1_hESC_TAF1 <- summarize_subset(subset_H1_hESC_TAF1)
summary_H1_hESC_YY1 <- summarize_subset(subset_H1_hESC_YY1)

# Combine the summaries into a single data frame
group_summary <- bind_rows(
  mutate(summary_H1_hESC_YY1_TAF1, gene_list = "H1-hESC_YY1_TAF1_com"),
  mutate(summary_H1_hESC_TAF1, gene_list = "H1-hESC_TAF1_exclu"),
  mutate(summary_H1_hESC_YY1, gene_list = "H1-hESC_YY1_exclu")
)

# Display the summary data frame
print(group_summary)


