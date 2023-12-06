# Load required libraries
library(TFregulomeR)  # For transcription factor regulome analysis
library(tidyverse)    # For data manipulation and visualization
library(parallel)     # For parallel computing

# Iterate over a fixed range of values that represents all tissue cell lines available in TFregulomeR (1 to 414)
for (j in 1:414) {
  
  # Set the number of cores for parallel processing
  num_cores <- 14
  
  # Retrieve all records from TFregulomeR database
  all_records <- dataBrowser()
  
  # Define main directory and database path
  main_dir <- "/home/gaston/mun/CEBD_DMT3D/tfregulome_tutorial"
  db_path <- file.path(main_dir, "TFregulomeR_database_2.1/tfregulome.sqlite")
  
  # Create a subdirectory and set it as the working directory
  sub_dir <- "attempt"
  dir.create(file.path(main_dir, sub_dir), showWarnings = FALSE)
  setwd(file.path(main_dir, sub_dir))
  
  # Filter all_records for human records
  human_records <- dataBrowser(species = "human")
  
  # Get unique tissue names with more than 3 TFs for human
  unique_tissues <- unique(human_records$cell_tissue_name)
  
  # Select a tissue based on the iteration index
  tissue_TFBS <- unique_tissues[j]
  temp_big <- dataBrowser(cell_tissue_name = tissue_TFBS)
  
  # Print current tissue and iteration information
  print(paste0("-------", tissue_TFBS,"-------", j,"-------"))
  
  # Create a directory for the current tissue TFBS and set it as the working directory
  TFBS_dir <- paste0("attempt/", tissue_TFBS)
  dir.create(file.path(main_dir, TFBS_dir))

  # Check if temp_big is not null and has more than 2 rows
  if (!is.null(temp_big) && nrow(temp_big) > 2) {

# Set up a placeholder for the results
  results <- data.frame(peak_id = character(), comparison = character(), SqDiff = numeric())
  
# Wrap the body of the for loop into a function
process_peak_id <- function(i) {
  # Your original for loop body starts here
  peak_id_01 <- temp_big$ID[i]
  TF_01 <- temp_big$TF[i]
  
  name_01 <- paste0(TFBS_dir, "/", tissue_TFBS, "_", TF_01)
  
  sub_dir <- name_01
  dir.create(file.path(main_dir, sub_dir))
  setwd(file.path(main_dir, sub_dir))
  
  unique(temp_big$TF)

  intersectMatrix_01 <- intersectPeakMatrix(peak_id_x = peak_id_01, motif_only_for_id_x = TRUE, peak_id_y = temp_big$ID, motif_only_for_id_y = TRUE, local_db_path = db_path)
  
  result_01 <- intersectPeakMatrixResult(intersectPeakMatrix = intersectMatrix_01, return_intersection_matrix = TRUE, angle_of_matrix = "x")
  
  result_01_t <- data.frame(t(result_01$intersection_matrix))
  first_column <- colnames(result_01_t)[1]
  result_01_order <- result_01_t[order(-result_01_t[,first_column]),, drop = FALSE]
  
  head(result_01_order, n = 5)
  
  
  top_cobinding <- rownames(head(result_01_order, n = 5))
  top_cobinding
  
  
###################################
  
  name_01b <- paste0(name_01, "/inclusion_txt")
  
  sub_dir <- name_01b
  dir.create(file.path(main_dir, sub_dir))
  setwd(file.path(main_dir, sub_dir))
  intersectPeakMatrixResult(intersectPeakMatrix = intersectMatrix_01, save_MethMotif_logo = TRUE, angle_of_logo = "x", saving_MethMotif_logo_y_id = top_cobinding)
  temp <- intersectPeakMatrix(peak_id_x = peak_id_01, motif_only_for_id_x = TRUE, peak_id_y = top_cobinding, motif_only_for_id_y = TRUE, local_db_path = db_path)
  exportMMPFM(fun_output = temp, fun = "intersectPeakMatrix",save_motif_PFM = TRUE, save_betaScore_matrix = TRUE)

###

name_01b <- paste0(name_01, "/exclusion_txt")

sub_dir <- name_01b
dir.create(file.path(main_dir, sub_dir))
setwd(file.path(main_dir, sub_dir))

exclusive_list <- list() # create an empty list to store results

# Get the base filename by running exclusivePeaks with the first peak
base_exclusive <- exclusivePeaks(
  target_peak_id = peak_id_01, 
  motif_only_for_target_peak = TRUE, 
  excluded_peak_id = top_cobinding[2], 
  motif_only_for_excluded_peak = TRUE, 
  local_db_path = db_path)

# Export the results of base_exclusive
exportMMPFM(fun_output = base_exclusive, 
            fun = "exclusivePeaks", 
            save_motif_PFM = TRUE, 
            save_betaScore_matrix = TRUE)

exclusivePeakResult(exclusivePeaks = base_exclusive, 
                    return_exclusive_peak_sites = TRUE, 
                    save_MethMotif_logo = TRUE, 
                    return_methylation_profile = TRUE)

# Get the base filenames from the current directory
base_files <- list.files()

# Iterate over each value in top_cobinding
for (i in 1:length(top_cobinding)) {
  exclusive <- exclusivePeaks(
    target_peak_id = peak_id_01, 
    motif_only_for_target_peak = TRUE, 
    excluded_peak_id = top_cobinding[i], 
    motif_only_for_excluded_peak = TRUE, 
    local_db_path = db_path)
  
  # Add the exclusive peaks to the list
  exclusive_list[[i]] <- exclusive
  
  # Export the results of exclusivePeaks for each top_cobinding[i]
  exportMMPFM(fun_output = exclusive, 
              fun = "exclusivePeaks", 
              save_motif_PFM = TRUE, 
              save_betaScore_matrix = TRUE)
  
  # Generate MethMotif logos and methylation profiles
  exclusivePeakResult(exclusivePeaks = exclusive, 
                      return_exclusive_peak_sites = TRUE, 
                      save_MethMotif_logo = TRUE, 
                      return_methylation_profile = TRUE)
  
  # Get the list of files in the current working directory
  files <- list.files()
  
  # Rename the files
  for (j in 1:length(files)) {
    if (files[j] %in% base_files) {
      new_file_name <- paste0(top_cobinding[i], "_", files[j])
      file.rename(files[j], new_file_name)
    }
  }
}

names(exclusive_list) <- top_cobinding # name list elements by peak id




#######

sub_dir <- name_01
setwd(file.path(main_dir, sub_dir))

# Extract the transcription factor names
tf_names <- sapply(strsplit(top_cobinding, "_"), tail, n = 1)

# Get all methScore.txt files in the inclusion_txt and exclusion_txt directories
inclusion_files <- list.files(path = "inclusion_txt", pattern = "-methScore.txt$", full.names = TRUE, recursive = TRUE)
exclusion_files <- list.files(path = "exclusion_txt", pattern = "-methScore.txt$", full.names = TRUE, recursive = TRUE)

# Initialize lists to store the data frames
inclu_meth_score <- list()
exclu_meth_score <- list()


# create an if condition for if there is no methylation
inclu_pattern <- paste0(tf_names[1], "-methScore.txt$")
inclu_file <- inclusion_files[grepl(inclu_pattern, inclusion_files)]

# Check if 'results' does not exist in the environment
if(!exists("results")){
  # Initialize an empty data frame to store the results
  results <- data.frame(peak_id = character(), comparison = character(), SqDiff = numeric())
}

if (length(inclu_file) > 0) {
# Iterate over each transcription factor
for (i in 1:length(tf_names)) {
  
  # Construct the file name pattern for this transcription factor
  inclu_pattern <- paste0(tf_names[i], "-methScore.txt$")
  exclu_pattern <- paste0(tf_names[i], "_", peak_id_01, "_exclusive_peaks-methScore.txt$")
  
  # Find the matching file in the inclusion_files and exclusion_files lists
  inclu_file <- inclusion_files[grepl(inclu_pattern, inclusion_files)]
  exclu_file <- exclusion_files[grepl(exclu_pattern, exclusion_files)]
  
  # If matching files were found, read them into data frames and store them in the lists
  if (length(inclu_file) > 0 && length(exclu_file) > 0) {
    inclu_meth_score[[i]] <- read.table(inclu_file, sep = "\t", header = TRUE)
    exclu_meth_score[[i]] <- read.table(exclu_file, sep = "\t", header = TRUE)
  }
}

# Add names to the lists
names(inclu_meth_score) <- tf_names
names(exclu_meth_score) <- tf_names

# Iterate over each pair of files
for (i in 1:length(tf_names)) {
  
  # Load the data frames
  in_meth_score <- inclu_meth_score[[i]]
  ex_meth_score <- exclu_meth_score[[i]]
  
  # Calculating the column sums for meth_score
  # Finding the largest column sum in meth_score
  in_meth_score_col_sums <- colSums(in_meth_score[, -1])
  ex_meth_score_col_sums <- colSums(ex_meth_score[, -1])
  largest_meth_score_sum <- min(max(in_meth_score_col_sums), max(ex_meth_score_col_sums))
  
  # Calculate the normalized ratios
  in_meth_score_ratio <- in_meth_score[, -1] / sum(in_meth_score[, -1])
  ex_meth_score_ratio <- ex_meth_score[, -1] / sum(ex_meth_score[, -1])
  
  # Replace any NaN or NA with 0
  in_meth_score_ratio[is.na(in_meth_score_ratio)] <- 0
  ex_meth_score_ratio[is.na(ex_meth_score_ratio)] <- 0
  
  in_meth_row_sum_norm <- rowSums(in_meth_score_ratio)
  inclu_no_meth <- as.integer(in_meth_row_sum_norm[[1]] > .95 || sum(in_meth_score_col_sums) < 10)
  ex_meth_row_sum_norm <- rowSums(ex_meth_score_ratio)
  exclu_no_meth <- as.integer(ex_meth_row_sum_norm[[1]] > .95 || sum(ex_meth_score_col_sums) < 10)
  
  if ((inclu_no_meth == 1 && exclu_no_meth == 1) || largest_meth_score_sum < 25 ) {
    sq_diff <- 0
  } else if (inclu_no_meth == 1) {
    sq_diff <- (sum(ex_meth_row_sum_norm[2:3]))^2
  } else if (exclu_no_meth == 1) {
    sq_diff <- (sum(in_meth_row_sum_norm[2:3]))^2
  } else {
    # Subtract the ratios
    diff_ratio <- in_meth_score_ratio - ex_meth_score_ratio
    # Calculate sum of squares divided by the number of positions
    sq_diff <- sum(diff_ratio^2)
  }
  
  # Add the results to the data frame
  results <- rbind(results, data.frame(peak_id = peak_id_01 , comparison = names(exclu_meth_score)[i], SqDiff = sq_diff))
}

}

# Check if the 'results' data frame is empty
if (nrow(results) == 0) {
  # If it is, add a row of zeros
  results <- rbind(results, data.frame(peak_id = 0, comparison = 0, SqDiff = 0))
}

return(results)

}

# Apply process_peak_id to each element of temp_big$ID in parallel
results_list <- mclapply(1:length(temp_big$ID), process_peak_id, mc.cores = num_cores)


# Combine the results from each iteration
results <- do.call(rbind, results_list)

# View the results
print(results)
sub_dir <- "attempt"
setwd(file.path(main_dir, sub_dir))

}

# Save the current R environment to a file
save.image(file = paste0(tissue_TFBS, ".RData"))
write_tsv(results, file = paste0(tissue_TFBS, ".tsv"))

}


# Additional code for loading results, filtering, and visualizing data:
# - Load and filter the results.
# - Create histograms and calculate summary statistics.
# - Identify and process subsets based on statistical criteria.

# ############################
# 
# # Load required packages
# library(ggplot2)
# library(dplyr)
# 
# 
# results <- read.table("results.tsv", header = TRUE, sep = "\t", fill = TRUE, quote = "")
# results <- unique(results)
# 
# 
# # Convert SqDiff to numeric
# results$SqDiff <- as.numeric(as.character(results$SqDiff))
# 
# # Remove rows with NA in SqDiff or inclu_meth_rd
# results <- results %>%
#   filter(!is.na(SqDiff), !is.na(inclu_meth_rd))
# 
# # Remove rows where peak_id or comparison is 0 (the repeated header rows)
# results <- results %>%
#   filter(peak_id != 0, comparison != 0)
# 
# results_subset <- results %>%
#   filter(SqDiff > 0)
# 
# 
# # You can then re-run your ggplot code to create the histogram:wrt
# ggplot(results_subset, aes(x = SqDiff)) +
#   geom_histogram(fill = "lightblue", color = "black", bins = 100) +
#   labs(x = "SqDiff", y = "Frequency", title = "Distribution of SqDiff") +
#   theme_minimal()
# 
# # And the summary statistics:
# summary_stats <- results_subset %>%
#   summarize(
#     Mean = mean(SqDiff, na.rm = TRUE),
#     Median = median(SqDiff, na.rm = TRUE),
#     SD = sd(SqDiff, na.rm = TRUE),
#     Min = min(SqDiff, na.rm = TRUE),
#     Max = max(SqDiff, na.rm = TRUE)
#   )
# 
# print(summary_stats)
# 
# # Calculate median and standard deviation
# mean_val <- mean(results_subset$SqDiff)
# sd_value <- sd(results_subset$SqDiff)
# 
# # Create subset based on the initial subset
# subset_1z <- results_subset[results_subset$SqDiff > mean_val + sd_value, ]
# 
# # Print the subset
# print(subset)
# 
# 
# # Add new column to the end
# subset_1z$transcription_factor <- sapply(strsplit(as.character(subset_1z$peak_id), "_"), function(x) x[length(x)])
# 
# # Move new column to the second position
# subset_1z <- subset_1z[, c(1,ncol(subset_1z),2:(ncol(subset_1z)-1))]

