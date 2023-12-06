#!/bin/bash

export PATH=$PATH:/home/gaston/doc/programs
source ~/.bashrc  # or source ~/.bash_profile

export PATH=$PATH:/home/gaston/doc/programs/FastQC
source ~/.bashrc  # or source ~/.bash_profile

export PATH=$PATH:/home/gaston/doc/programs/TrimGalore-0.6.10
source ~/.bashrc  # or source ~/.bash_profile

pt='/home/gaston/doc/programs'

# Define the file prefixes
prefixes=("ENCFF000KIP" "ENCFF000KJL")

# Define the index file
INDEX="/home/gaston/mun/CEBD_DMT3D/lab_proj_my_work/RNA-seq/ref/salmon_default_hg38_index"

# Function for parallel processing
process_files() {
    prefix=$1

    # Define the input files for single-end
    read1="${prefix}.fastq"

    # Run fastp on the single-end file
    fastp -i $read1 -o "${prefix}.fastp.fastq"

    # Run Trim Galore! on the single-end file and output to a subfolder
    mkdir -p ./${prefix}_trimmed_files
    trim_galore "${prefix}.fastp.fastq" -o "./${prefix}_trimmed_files"

    # Rename trimmed files
    trimmed1="./${prefix}_trimmed_files/${prefix}.fastp_trimmed.fq"

    # Run FastQC on the trimmed file
    mkdir -p ./${prefix}_fastqc
    fastqc $trimmed1 -o "./${prefix}_fastqc/"
}

export -f process_files

# Use GNU Parallel to run the function in parallel
parallel process_files ::: ${prefixes[@]}

# Loop over each file prefix
for prefix in "${prefixes[@]}"
do
    trimmed1="./${prefix}_trimmed_files/${prefix}.fastp_trimmed.fq"

    # Define the output directory
    OUTPUT_DIR="salmon_output_${prefix}"

    # Run salmon for single-end
    mkdir -p ./${OUTPUT_DIR}
    salmon quant -i $INDEX -l A -r $trimmed1 -p 16 --validateMappings -o ./${OUTPUT_DIR}
done
