# Libraries
library(tximport)
library(biomaRt)
library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)
library(scales)
library(stats)

# Define function to extract promoter-TSS gene names
extract_promoter_genes <- function(filename) {
  df <- read.csv(filename, header=TRUE, sep=",")
  df <- df[df$annotation == "promoter-TSS", ]  # Filter rows by promoter-TSS
  return(df$geneName)  # Return gene names
}

# Read in Gene Lists for the three files
gm12878_taf1_exclu_yy1_genes <- read.csv("peaks_list/gm12878_taf1_exclu_yy1_peaks.csv", header=TRUE, sep=",")$geneName
gm12878_promo_taf1_exclu_yy1_genes <- extract_promoter_genes("peaks_list/gm12878_taf1_exclu_yy1_peaks.csv")
gm12878_yy1_com_taf1_genes <- read.csv("peaks_list/gm12878_yy1_com_taf1_peaks.csv", header=TRUE, sep=",")$geneName
gm12878_promo_yy1_com_taf1_genes <- extract_promoter_genes("peaks_list/gm12878_yy1_com_taf1_peaks.csv")
gm12878_yy1_exclu_taf1_genes <- read.csv("peaks_list/gm12878_yy1_exclu_taf1_peaks.csv", header=TRUE, sep=",")$geneName
gm12878_promo_yy1_exclu_taf1_genes <- extract_promoter_genes("peaks_list/gm12878_yy1_exclu_taf1_peaks.csv")

# Assigning the files to a list
files_GM12878 <- c("salmon_out_GM12878/salmon_output_ENCLB040ZZZ/quant.sf",
                   "salmon_out_GM12878/salmon_output_ENCLB039ZZZ/quant.sf")
txi_GM12878 <- tximport(files_GM12878, type = "salmon", txOut = TRUE)
tpm_GM12878 <- txi_GM12878$abundance
tpm_GM12878 <- as.data.frame(tpm_GM12878)

# Getting gene annotation
ensembl <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")
transcripts <- getBM(attributes = c("ensembl_transcript_id_version", "external_gene_name"), mart = ensembl)
final_tpm_GM12878 <- tpm_GM12878 %>%
  mutate(gene_symbol = sub("\\..*", "", transcripts$external_gene_name[match(rownames(.), transcripts$ensembl_transcript_id_version)])) %>%
  filter(!(rowSums(.[, -ncol(.)]) == 0 | is.na(gene_symbol))) %>%
  group_by(gene_symbol) %>%
  summarize(across(everything(), sum))

# Subset TPM Data for both total and promoter-TSS gene lists
subset_data <- function(df, genes) {
  return(df[df$gene_symbol %in% genes, ])
}

all_subsets <- list(
  subset_data(final_tpm_GM12878, gm12878_yy1_exclu_taf1_genes),
  subset_data(final_tpm_GM12878, gm12878_promo_yy1_exclu_taf1_genes),
  subset_data(final_tpm_GM12878, gm12878_taf1_exclu_yy1_genes),
  subset_data(final_tpm_GM12878, gm12878_promo_taf1_exclu_yy1_genes),
  subset_data(final_tpm_GM12878, gm12878_yy1_com_taf1_genes),
  subset_data(final_tpm_GM12878, gm12878_promo_yy1_com_taf1_genes)
)

# Update the gene list names without the "gm12878_" prefix
gene_list_names <- c(
  "yy1_exclu_taf1", "promo_yy1_exclu_taf1",
  "taf1_exclu_yy1", "promo_taf1_exclu_yy1",
  "yy1_com_taf1", "promo_yy1_com_taf1"
)

# Combine data for plotting
df_for_plot <- bind_rows(lapply(1:6, function(i) {
  mutate(all_subsets[[i]], gene_list = gene_list_names[i])
}))

df_for_plot$avg_expression <- rowMeans(df_for_plot[, -c(1, ncol(df_for_plot))], na.rm=TRUE)

# Adjust the colors and plotting code for the boxplots
colors <- c(
  "red", "lightcoral", 
  "blue", "lightblue",
  "green", "lightgreen"
)

# Create a data frame for the "N=" labels
counts <- as.data.frame(table(df_for_plot$gene_list))
colnames(counts) <- c("gene_list", "count")
counts$text <- paste("N =", counts$count)

# Adjust gene_list to factor with desired order
df_for_plot$gene_list <- factor(df_for_plot$gene_list, 
                                levels = gene_list_names)

# Plotting with a logarithmic y-axis
p <- ggplot(df_for_plot, aes(x = gene_list, y = avg_expression)) +
  geom_boxplot(aes(fill = gene_list), outlier.shape = 1, outlier.color = "black") +
  geom_text(data = counts, aes(x = gene_list, y = Inf, label = text), vjust = 2) +  # Add "N=" above each boxplot
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_fill_manual(values = colors, 
                    breaks = gene_list_names,
                    labels = c("yy1 exclu taf1", "promo yy1 exclu taf1", "taf1 exclu yy1", "promo taf1 exclu yy1", "yy1 com taf1", "promo yy1 com taf1")) +
  theme_minimal() +
  labs(title = "TPM Distribution across gene related to binding sites of YY1, TAF1 in GM12878",
       x = "Gene Group",
       y = "TPM (Log Scale)") +
  theme(legend.position = "bottom")  # Places the legend at the bottom 

# Display the plot
print(p)


# Statistical Analysis
result.aov <- aov(avg_expression ~ gene_list, data = df_for_plot)
summary(result.aov)
pairwise <- TukeyHSD(result.aov, "gene_list")

print(pairwise)

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
summary_yy1_exclu_taf1 <- summarize_subset(subset_data(final_tpm_GM12878, gm12878_yy1_exclu_taf1_genes))
summary_promo_yy1_exclu_taf1 <- summarize_subset(subset_data(final_tpm_GM12878, gm12878_promo_yy1_exclu_taf1_genes))
summary_taf1_exclu_yy1 <- summarize_subset(subset_data(final_tpm_GM12878, gm12878_taf1_exclu_yy1_genes))
summary_promo_taf1_exclu_yy1 <- summarize_subset(subset_data(final_tpm_GM12878, gm12878_promo_taf1_exclu_yy1_genes))
summary_yy1_com_taf1 <- summarize_subset(subset_data(final_tpm_GM12878, gm12878_yy1_com_taf1_genes))
summary_promo_yy1_com_taf1 <- summarize_subset(subset_data(final_tpm_GM12878, gm12878_promo_yy1_com_taf1_genes))

# Combine the summaries into a single data frame
group_summary <- bind_rows(
  mutate(summary_yy1_exclu_taf1, gene_list = "yy1_exclu_taf1"),
  mutate(summary_promo_yy1_exclu_taf1, gene_list = "promo_yy1_exclu_taf1"),
  mutate(summary_taf1_exclu_yy1, gene_list = "taf1_exclu_yy1"),
  mutate(summary_promo_taf1_exclu_yy1, gene_list = "promo_taf1_exclu_yy1"),
  mutate(summary_yy1_com_taf1, gene_list = "yy1_com_taf1"),
  mutate(summary_promo_yy1_com_taf1, gene_list = "promo_yy1_com_taf1")
)

# Display the summary data frame
print(group_summary)