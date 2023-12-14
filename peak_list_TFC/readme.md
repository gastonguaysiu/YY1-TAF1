**TAG FOLD CHANGE ANALYSIS OF YY1-TAF1**

**Overview**

Analyzing ChIP-seq data for YY1 transcription factor peaks in selected cell lines reveals a positively skewed distribution, predominantly in the 8-13 range. This pattern suggests common behaviour for YY1 in this range. A closer look at YY1 and TAF1 co-binding shows a shift towards a platykurtic distribution, indicating a unique interaction between these factors. This change implies a different functional dynamic than YY1 acting alone, suggesting a nuanced interplay and complex formation between YY1 and TAF1. The distinct behaviour when YY1 and TAF1 co-bind, as opposed to YY1's independent action, highlights a synergistic, complex regulatory mechanism.

![TFC analysis of YY1-TAF1 co-binding](https://github.com/gastonguaysiu/YY1-TAF1/blob/main/peak_list_TFC/Screenshot%20from%202023-12-06%2012-13-48.png?raw=true)

**contents**

Folders:

 - GM12878: contains two files containing data from the GM12878 cell line ChIP-Seq. The first lists all common peaks in the ChIP-Seq analysis between YY1 and TAF1, suggesting co-binding; the TFC of this file was pulled from the YY1 ChIP-Seq. The other file contains all the YY1 peaks for the cell line.
 - H1-hESC: contains two files containing data from the H1-hESC cell line ChIP-Seq. The first lists all common peaks in the ChIP-Seq analysis between YY1 and TAF1, suggesting co-binding; the TFC of this file was pulled from the YY1 ChIP-Seq. The other file contains all the YY1 peaks for the cell line.
 - SK-N-SH: contains two files containing data from the SK-N-SH cell line ChIP-Seq. The first lists all common peaks in the ChIP-Seq analysis between YY1 and TAF1, suggesting co-binding; the TFC of this file was pulled from the YY1 ChIP-Seq. The other file contains all the YY1 peaks for the cell line.

Scripts:

 - TFC_density.R: build density plots seen above based on the Tag Fold Change information, to compare the binding behaviour of YY1 peaks overall to the subset of YY1 peaks that co-bind with TAF1
