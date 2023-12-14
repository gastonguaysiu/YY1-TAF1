**TPM ANALYSIS OF TF PAIR**

**overview**

![flowchart to get the TPM of the genes associated with YY1-TAF1 co-binging sites](https://github.com/gastonguaysiu/YY1-TAF1/blob/main/TPM/Screenshot%20from%202023-12-05%2021-22-55.png?raw=true)

The flowchart above illustrates the step-by-step process and tools used for RNA-seq data analysis in gene expression analysis. It visually represents each processing stage, including data cleaning with Fastp and Trim Galore!, quantification of data quality with FastQC, and transcript quantification with Salmon. This image can be a useful guide for understanding the gene expression analysis process. Please take a look at pipeline5_gm12878.sh and pipeline6_skNsh.sh for more details.



**Contents**

Folders/Files:

 - ./salmon_out_GM12878/rna_seq_file_info/ the information from running the pipeline bash script contains data on the quality of the reads where the information was downloaded.
 - ./salmon_out_GM12878/salmon_output_*/quant.sf: this file contains the TPM for each of the ensemble gene and splicing variant
 - ./salmon_out_H1_hESC/ contains the same files and data as the GM12878 folder, but instead is for the H1-hESC cell line

Scripts:

 - pipeline*.sh: these shell scripts run the fastq files through quality control, read trimming and transcript quantification. It does assume that the user has installed and operates on a Linux-based system and that the following software tools have been installed: FastQC, Trim Galore!, and Salmon.
 - box_tpm_*.R: script builds boxplots depicting the Transcripts Per Million (TPM) levels of genes associated with YY1 and TAF1 across GM12878 and H1-hESC cell lines. The plot segregates data based on the exclusive and co-bound peaks identified in the ChIP-seq analysis. It also provides information of the peaks in the promoter-TSS region
