#!/bin/bash

export PATH=$PATH:/home/gaston/doc/programs
source ~/.bashrc  # or source ~/.bash_profile

export PATH=$PATH:/home/gaston/doc/programs/FastQC
source ~/.bashrc  # or source ~/.bash_profile

export PATH=$PATH:/home/gaston/doc/programs/TrimGalore-0.6.10
source ~/.bashrc  # or source ~/.bash_profile

pt='/home/gaston/doc/programs'

# Define the file prefixes
prefixes=("ENCLB039ZZZ" "ENCLB040ZZZ")

# # Define the index file
# # build index for your reference transcriptome
# salmon index -t $reference -i ./salmon_hg38_index --decoys decoys.txt -k 31
INDEX="/home/gaston/mun/CEBD_DMT3D/lab_proj_my_work/RNA-seq/ref/salmon_default_hg38_index"

# # Function for parallel processing
# process_files() {
#     prefix=$1
#
#     # Define the input files
#     read1="${prefix}_1.fastq"
#     read2="${prefix}_2.fastq"
#
#     # Run fastp on the files
#     fastp -i $read1 -I $read2 -o "${prefix}_1.fastp.fastq" -O "${prefix}_2.fastp.fastq"
#
#     # Run Trim Galore! on the files and output to a subfolder
#     mkdir -p ./${prefix}_trimmed_files
#     trim_galore --paired "${prefix}_1.fastp.fastq" "${prefix}_2.fastp.fastq" -o "./${prefix}_trimmed_files"
#
#     # Rename trimmed files
#     trimmed1="./${prefix}_trimmed_files/${prefix}_1.fastp_val_1.fq"
#     trimmed2="./${prefix}_trimmed_files/${prefix}_2.fastp_val_2.fq"
#
#     # Run FastQC on the trimmed files
#     mkdir -p ./${prefix}_fastqc
#     fastqc $trimmed1 $trimmed2 -o "./${prefix}_fastqc/"
# }
#
# export -f process_files

# Use GNU Parallel to run the function in parallel
parallel process_files ::: ${prefixes[@]}

# Loop over each file prefix
for prefix in "${prefixes[@]}"
do
    trimmed1="./${prefix}_trimmed_files/${prefix}_1.fastp_val_1.fq"
    trimmed2="./${prefix}_trimmed_files/${prefix}_2.fastp_val_2.fq"

    # Define the output directory
    OUTPUT_DIR="salmon_output_${prefix}"

    # Run salmon
    mkdir -p ./${OUTPUT_DIR}
    salmon quant -i $INDEX -l A -1 $trimmed1 -2 $trimmed2 -p 16 --validateMappings -o ./${OUTPUT_DIR}
done
