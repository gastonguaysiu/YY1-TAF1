# Define function to extract promoter-TSS gene names
extract_promoter_genes <- function(filename) {
  df <- read.csv(filename, header=TRUE, sep=",")
  df <- df[df$annotation == "promoter-TSS", ]  # Filter rows by promoter-TSS
  return(df$geneName)  # Return gene names
}

# Extracting Gene Lists

sk_n_sh_taf1_exclu_yy1_genes <- extract_promoter_genes("sk_n_sh_taf1_exclu_yy1_peaks.csv")
sk_n_sh_yy1_com_taf1_genes <- extract_promoter_genes("sk_n_sh_yy1_com_taf1_peaks.csv")
sk_n_sh_yy1_exclu_taf1_genes <- extract_promoter_genes("sk_n_sh_yy1_exclu_taf1_peaks.csv")

# Saving the extracted gene lists to TSV files

write.table(sk_n_sh_taf1_exclu_yy1_genes, "./promo_genes_lists/sk_n_sh_promo_taf1_exclu_yy1_genes.tsv", sep="\t", col.names=FALSE, row.names=FALSE)
write.table(sk_n_sh_yy1_com_taf1_genes, "./promo_genes_lists/sk_n_sh_promo_yy1_com_taf1_genes.tsv", sep="\t", col.names=FALSE, row.names=FALSE)
write.table(sk_n_sh_yy1_exclu_taf1_genes, "./promo_genes_lists/sk_n_sh_promo_yy1_exclu_taf1_genes.tsv", sep="\t", col.names=FALSE, row.names=FALSE)
