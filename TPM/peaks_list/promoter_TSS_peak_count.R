# Define a function to count promoter-TSS peaks in a file
count_promoter_peaks <- function(filename) {
  df <- read.csv(filename, header=TRUE, sep=",")
  promo_df <- df[df$annotation == "promoter-TSS", ]
  return(nrow(promo_df))
}

# List of files
files <- c(
  "./gm12878_taf1_exclu_yy1_peaks.csv",
  "./gm12878_yy1_com_taf1_peaks.csv",
  "./gm12878_yy1_exclu_taf1_peaks.csv",
  "./h1_hesc_taf1_exclu_yy1_peaks.csv",
  "./h1_hesc_yy1_com_taf1_peaks.csv",
  "./h1_hesc_yy1_exclu_taf1_peaks.csv",
  "./sk_n_sh_taf1_exclu_yy1_peaks.csv",
  "./sk_n_sh_yy1_com_taf1_peaks.csv",
  "./sk_n_sh_yy1_exclu_taf1_peaks.csv"
)

# Apply the function to count promoter-TSS peaks for each file
counts <- sapply(files, count_promoter_peaks)

# Display the results
for (i in seq_along(files)) {
  cat(basename(files[i]), ":", counts[i], "\n")
}

# Display the total count
cat("Total promoter-TSS peaks:", sum(counts), "\n")
