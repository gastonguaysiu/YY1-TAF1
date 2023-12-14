# YY1-TAF1

**transcription factor YY1-TAF1 cobinding analysis**

For our study on methylation changes in transcription factor (TF) co-binding, we utilized TFregulomeR, which offers insights into context-dependent and independent peaks between TF pairs. The **evaluate_all_tissue.R** systematically evaluates various combinations of TFs to guide data collection from DNA methylation matrices and read enrichment scores. We selected 414 human cell lines from TFregulomeR, each requiring ChIP-seq data for a minimum of three different TFs for further analysis. In cell lines with extensive ChIP-seq data, we focused on each TF's top five co-binding partners.

Our analysis centred on comparing two transcription factor binding motifs scenarios: co-binding of TF pairs and individual TF binding excluding co-binding peaks (exclusive TF peaks). This approach enabled us to evaluate changes in methylation status when TFs operate independently versus in tandem. We employed TFregulomeR to obtain methylation data, counting methylated peaks per base pair where TFs bind. 
We set specific exclusion criteria for methylated peaks. If a dataset had fewer than ten total methylated peaks or over 95% of the peaks exhibited low methylation levels (below 10%), we classified it as "unmethylated" for further comparisons.

The TF pairs and exclusive TF data were organized into matrices, categorized by low, intermediate, and high methylation levels, and aligned with corresponding base pairs within the binding motif. We normalized peak counts for comparison, calculated a pseudo-sum-of-squares difference between the matrices, and summed up these differences for a meaningful comparison between the two scenarios.

Our statistical analysis pinpointed TF pairs with significant methylation changes, exceeding one standard deviation above the average, resulting in 152 condition sets showing notable variations. Among these, the YY1-TAF1 pair in GM12878 and H1-hESC cell lines was of interest.

We leveraged various functionalities of TFregulomeR, including data browsing, motif logo visualization (plotLogo), importing peak regions (loadPeaks), extracting motif PWMs and methylation matrices (exportMMPFM), and analyzing interactions between TF cofactors (intersectPeakMatrix, exclusivePeaks). We also considered the Tag fold change for each fragment in our peak information.

To elucidate the biological implications of our findings, we performed Gene Ontology (GO) analysis on genes associated with promoter-TSS sites derived from ChIP-Seq data under the three conditions using TFregulomeR and MethMotif.

**subfolder tree**

![git_folder_tree](https://github.com/gastonguaysiu/YY1-TAF1/blob/main/git_tree.png?raw=true)
