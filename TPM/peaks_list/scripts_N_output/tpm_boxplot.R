# Libraries
library(tximport)
library(biomaRt)
library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)
library(scales)
library(stats)


# Read in Gene Lists for the three files
gm12878_taf1_exclu_yy1_genes <- read.csv("peaks_list/gm12878_taf1_exclu_yy1_peaks.csv", header=TRUE, sep=",")$geneName
gm12878_yy1_com_taf1_genes <- read.csv("peaks_list/gm12878_yy1_com_taf1_peaks.csv", header=TRUE, sep=",")$geneName
gm12878_yy1_exclu_taf1_genes <- read.csv("peaks_list/gm12878_yy1_exclu_taf1_peaks.csv", header=TRUE, sep=",")$geneName

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

# Subset TPM Data for the new gene lists
subset_gm12878_taf1_exclu_yy1 <- final_tpm_GM12878[final_tpm_GM12878$gene_symbol %in% gm12878_taf1_exclu_yy1_genes, ]
subset_gm12878_yy1_com_taf1 <- final_tpm_GM12878[final_tpm_GM12878$gene_symbol %in% gm12878_yy1_com_taf1_genes, ]
subset_gm12878_yy1_exclu_taf1 <- final_tpm_GM12878[final_tpm_GM12878$gene_symbol %in% gm12878_yy1_exclu_taf1_genes, ]

# Reshape Data for plotting (Changed order to `yy1_exclu`, `taf1_exclu`, `yy1_com`)
df_for_plot <- bind_rows(
  mutate(subset_gm12878_yy1_exclu_taf1, gene_list = "gm12878_yy1_exclu_taf1"),
  mutate(subset_gm12878_taf1_exclu_yy1, gene_list = "gm12878_taf1_exclu_yy1"),
  mutate(subset_gm12878_yy1_com_taf1, gene_list = "gm12878_yy1_com_taf1")
)

# Calculate average expression for each gene set
df_for_plot$avg_expression <- rowMeans(df_for_plot[, -c(1, ncol(df_for_plot))], na.rm=TRUE)

# Create a data frame for the "N=" labels
counts <- as.data.frame(table(df_for_plot$gene_list))
colnames(counts) <- c("gene_list", "count")
counts$text <- paste("N =", counts$count)

# Adjust gene_list to factor with desired order
df_for_plot$gene_list <- factor(df_for_plot$gene_list, 
                                levels = c("gm12878_yy1_exclu_taf1", 
                                           "gm12878_taf1_exclu_yy1", 
                                           "gm12878_yy1_com_taf1"))

# Plotting with a logarithmic y-axis
p <- ggplot(df_for_plot, aes(x = gene_list, y = avg_expression)) +
  geom_boxplot(aes(fill = gene_list), outlier.shape = 1, outlier.color = "black") +
  geom_text(data = counts, aes(x = gene_list, y = Inf, label = text), vjust = 2) +  # Add "N=" above each boxplot
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_fill_manual(values = c(
    "gm12878_yy1_exclu_taf1" = "red",
    "gm12878_taf1_exclu_yy1" = "blue",
    "gm12878_yy1_com_taf1" = "green"
  )) +
  theme_minimal() +
  labs(title = "TPM Distribution across gene related to binding sites of YY1, TAF1",
       x = "Gene Group",
       y = "TPM (Log Scale)") +
  theme(legend.position = "none")  # Removes the legend

# Display the plot
print(p)
