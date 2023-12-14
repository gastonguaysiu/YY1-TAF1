**STAT ANALYSIS OF TF PAIR**


**Overview**

This subfolder contains the raw results and analysis on the transcription factor (TF) pairs from the evaluate_all_tissue.R script. Our analysis centred on comparing two scenarios: co-binding of TF pairs and individual TF binding excluding co-binding peaks (exclusive TF peaks). 

**Contents**

Files:

 - results.tsv: contains the raw, unprocessed data of each transcription factor pair vs exclusion isolated from the evaluate_all_tissue.R script.
 - results_subset.tsv: is just a cleaner version of the results.tsv file, removing all rows that have 0 difference in methylation between the cobinding motif and exclusive binding motif
 - subset_mean.tsv and subset_z.tsv includes only the pairs of TFs that have a difference in methylation beyond a certain threshold, namely the mean and Z score repectively.

Scripts:

 - counts.py: compares the number of times a given pair of transcription factors are found to be across different cell line samples
