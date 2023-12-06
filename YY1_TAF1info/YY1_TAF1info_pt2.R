library(TFregulomeR)
library(tidyverse)
library(rGREAT)
library(rbokeh)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)

all_records <- dataBrowser()

main_dir <- "/home/gaston/mun/CEBD_DMT3D/tfregulome_tutorial"
db_path <- file.path(main_dir, "TFregulomeR_database_2.1/tfregulome.sqlite")

###############

sub_dir <- "fuck_around"
dir.create(file.path(main_dir, sub_dir), showWarnings = FALSE)
setwd(file.path(main_dir, sub_dir))

# Filter all_records for human records
human_records <- dataBrowser(species = "human")

# investigation of tissue_TFBS: GM12878, H1_hESC, HepG2, SK-N-SH
# investigation of TF_01: yy1 & TAF1

unique_tissues <- c("GM12878", "H1-hESC", "HepG2", "SK-N-SH")

### common peaks ###

for (tissue_TFBS in unique_tissues) {
  temp_big <- dataBrowser(cell_tissue_name = tissue_TFBS)
    
    peak_id_01 <- temp_big[temp_big$TF == "YY1", "ID"]
    peak_id_02 <- temp_big[temp_big$TF == "TAF1", "ID"]
    
    com <- commonPeaks(target_peak_id = peak_id_01, motif_only_for_target_peak = TRUE,
                        compared_peak_id = peak_id_02, motif_only_for_compared_peak = TRUE,
                        methylation_profile_in_narrow_region = TRUE)
    
    com_res <- commonPeakResult(commonPeaks = com, return_common_peak_sites = TRUE,
                                 save_MethMotif_logo = TRUE, return_methylation_profile = TRUE, return_summary = TRUE)
    
    peak_summary <- com_res$peak_summary
    com_peak_list <- com_res$common_peak_list
    methylation_profile <- com_res$methylation_profile
    
    peaks <- com_peak_list[[1]]
    motifDistrib_output <- motifDistrib(id = peak_id_01,
                                        peak_list = list(peaks),
                                        peak_id = peak_id_02)
    
    plotDistrib(motifDistrib = motifDistrib_output)
    
    
    
    com <- commonPeaks(target_peak_id = peak_id_02, motif_only_for_target_peak = TRUE,
                       compared_peak_id = peak_id_01, motif_only_for_compared_peak = TRUE,
                       methylation_profile_in_narrow_region = TRUE)
    
    com_res <- commonPeakResult(commonPeaks = com, return_common_peak_sites = TRUE,
                                save_MethMotif_logo = TRUE, return_methylation_profile = TRUE, return_summary = TRUE)
    
    peak_summary <- com_res$peak_summary
    com_peak_list <- com_res$common_peak_list
    methylation_profile <- com_res$methylation_profile
    
    peaks <- com_peak_list[[1]]
    motifDistrib_output <- motifDistrib(id = peak_id_02,
                                        peak_list = list(peaks),
                                        peak_id = peak_id_01)
    
    plotDistrib(motifDistrib = motifDistrib_output)
    
    
    temp_big <- dataBrowser(cell_tissue_name = tissue_TFBS)
    
    for (current_TF in c("YY1", "TAF1")) {
      peak_id_01 <- temp_big[temp_big$TF == current_TF , "ID"]
      
      indi <- commonPeaks(target_peak_id = peak_id_01, motif_only_for_target_peak = TRUE,
                          compared_peak_id = peak_id_01, motif_only_for_compared_peak = TRUE,
                          methylation_profile_in_narrow_region = TRUE)
      
      indi_res <- commonPeakResult(commonPeaks = indi, return_common_peak_sites = TRUE,
                                   save_MethMotif_logo = TRUE, return_methylation_profile = TRUE, return_summary = TRUE)
      
      peak_summary <- indi_res$peak_summary
      indi_peak_list <- indi_res$common_peak_list
      methylation_profile <- indi_res$methylation_profile
      
      peaks <- indi_peak_list[[1]]
      motifDistrib_output <- motifDistrib(id = peak_id_01,
                                          peak_list = list(peaks),
                                          peak_id = peak_id_01)
      
      plotDistrib(motifDistrib = motifDistrib_output)
    }
    
}
