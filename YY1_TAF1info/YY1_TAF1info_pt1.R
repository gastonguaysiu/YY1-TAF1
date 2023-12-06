library(TFregulomeR)
library(tidyverse)
library(rGREAT)
library(rbokeh)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)

all_records <- dataBrowser()

main_dir <- "/home/gaston/mun/tfregulome_tutorial"
db_path <- file.path(main_dir, "TFregulomeR_database_2.1/tfregulome.sqlite")

sub_dir <- "fuck_around"
dir.create(file.path(main_dir, sub_dir), showWarnings = FALSE)
setwd(file.path(main_dir, sub_dir))

unique_tissues <- c("GM12878", "H1-hESC", "HepG2", "SK-N-SH")

### info basic info about each cell line and TF ###

for (tissue_TFBS in unique_tissues) {
  
  temp_big <- dataBrowser(cell_tissue_name = tissue_TFBS)
  
  name_01 <- paste0("fuck_around/", tissue_TFBS)
  sub_dir <- name_01
  dir.create(file.path(main_dir, sub_dir))
  setwd(file.path(main_dir, sub_dir))
  
  peak_id_01 <- temp_big[temp_big$TF == "YY1", "ID"]
  peak_id_02 <- temp_big[temp_big$TF == "TAF1", "ID"]

  ### common peaks b/t YY1 and ATF1
  
  com <- commonPeaks(target_peak_id = peak_id_01, motif_only_for_target_peak = TRUE,
                         compared_peak_id = peak_id_02, motif_only_for_compared_peak = TRUE,
                         methylation_profile_in_narrow_region = TRUE)
  
  com_res <- commonPeakResult(commonPeaks = com, return_common_peak_sites = TRUE,
                                  save_MethMotif_logo = FALSE, return_methylation_profile = TRUE,
                                  return_summary = TRUE, meth_level = "all")
  
  com_peak_list <- com_res$common_peak_list
  com_peaks <- com_peak_list[[1]]
  write_tsv(com_peaks, file = paste0(tissue_TFBS, "_YY1_TAF1_com_peaks", ".tsv"))
  
  com_peaks_func <- greatAnnotate(peaks = com_peaks, return_annotation = TRUE)
  write_tsv(com_peaks_func, file = paste0(tissue_TFBS, "_YY1_TAF1_com_GO", ".tsv"))
  
  # make a copy of the data && use rGREAT to get associated genes
  com_peaks2 <- as.data.frame(com_peaks[,1:3], stringsAsFactors = FALSE)
  
  jobx <- submitGreatJob(com_peaks2, species = "hg38")
  
  # Get associated genes
  gene_table <- getRegionGeneAssociations(jobx)
  gene_table1 <- gene_table$annotated_genes
  genes <- unique(as.data.frame(gene_table1@unlistData))
  write_tsv(genes, file = paste0(tissue_TFBS, "_YY1_TAF1_com_genes_list", ".tsv"))
  
  ### exclusive peaks YY1 ###
  
  YY1_exclu <- exclusivePeaks(target_peak_id = peak_id_01, motif_only_for_target_peak = TRUE, 
                                              excluded_peak_id = peak_id_02, motif_only_for_excluded_peak = TRUE, 
                                              methylation_profile_in_narrow_region = TRUE)
  
  YY1_exclu_res <- exclusivePeakResult(exclusivePeaks = YY1_exclu, return_exclusive_peak_sites = TRUE,
                                                       save_MethMotif_logo = FALSE, return_methylation_profile = TRUE,
                                                       return_summary = TRUE, meth_level = "all")
  
  YY1_exclu_peak_list <- YY1_exclu_res$exclusive_peak_list
  YY1_exclu_peaks <- YY1_exclu_peak_list[[1]]
  write_tsv(YY1_exclu_peaks, file = paste0(peak_id_01, "_exclu_peaks", ".tsv"))
  
  YY1_exclu_peaks_func <- greatAnnotate(peaks = YY1_exclu_peaks, return_annotation = TRUE)
  write_tsv(YY1_exclu_peaks_func, file = paste0(peak_id_01, "_exclu_GO", ".tsv"))
  
  # make a copy of the data && use rGREAT to get associated genes
  YY1_exclu_peaks2 <- as.data.frame(YY1_exclu_peaks[,1:3], stringsAsFactors = FALSE)
  jobx_YY1 <- submitGreatJob(YY1_exclu_peaks2, species = "hg38")
  
  # Get associated genes
  gene_table_YY1 <- getRegionGeneAssociations(jobx_YY1)
  gene_table_YY1_1 <- gene_table_YY1$annotated_genes
  genes_YY1 <- unique(as.data.frame(gene_table_YY1_1@unlistData))
  write_tsv(genes_YY1, file = paste0(peak_id_01, "_exclu_genes_list", ".tsv"))
  
  ### exclusive peaks TAF1 ###
  
  TAF1_exclu <- exclusivePeaks(target_peak_id = peak_id_02, motif_only_for_target_peak = TRUE, 
                              excluded_peak_id = peak_id_01, motif_only_for_excluded_peak = TRUE, 
                              methylation_profile_in_narrow_region = TRUE)
  
  TAF1_exclu_res <- exclusivePeakResult(exclusivePeaks = TAF1_exclu, return_exclusive_peak_sites = TRUE,
                                       save_MethMotif_logo = FALSE, return_methylation_profile = TRUE,
                                       return_summary = TRUE, meth_level = "all")
  
  TAF1_exclu_peak_list <- TAF1_exclu_res$exclusive_peak_list
  TAF1_exclu_peaks <- TAF1_exclu_peak_list[[1]]
  write_tsv(TAF1_exclu_peaks, file = paste0(peak_id_02, "_exclu_peaks", ".tsv"))
  
  TAF1_exclu_peaks_func <- greatAnnotate(peaks = TAF1_exclu_peaks, return_annotation = TRUE)
  write_tsv(TAF1_exclu_peaks_func, file = paste0(peak_id_02, "_exclu_GO", ".tsv"))
  
  # make a copy of the data && use rGREAT to get associated genes
  TAF1_exclu_peaks2 <- as.data.frame(TAF1_exclu_peaks[,1:3], stringsAsFactors = FALSE)
  jobx_TAF <- submitGreatJob(TAF1_exclu_peaks2, species = "hg38")
  
  # Get associated genes
  gene_table_TAF <- getRegionGeneAssociations(jobx_TAF)
  gene_table_TAF1 <- gene_table_TAF$annotated_genes
  genes_TAF <- unique(as.data.frame(gene_table_TAF1@unlistData))
  write_tsv(genes_TAF, file = paste0(peak_id_02, "_exclu_genes_list", ".tsv"))
}
