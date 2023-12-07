import csv
from collections import defaultdict

def count_elements(data):
    transcription_factor_counter = defaultdict(int)
    comparison_counter = defaultdict(int)
    combination_counter = defaultdict(int)

    for row in data:
        transcription_factor = row["transcription_factor"]
        comparison = row["comparison"]
        combination = (transcription_factor, comparison)

        transcription_factor_counter[transcription_factor] += 1
        comparison_counter[comparison] += 1
        combination_counter[combination] += 1

    return transcription_factor_counter, comparison_counter, combination_counter

def write_to_tsv(transcription_factor_counter, comparison_counter, combination_counter, output_path):
    with open(output_path, 'w', newline='') as f:
        writer = csv.writer(f, delimiter='\t')

        # Header
        writer.writerow(["TF Name", "TF Count", "Comparison Name", "Comparison Count", "Combination", "Combination Count"])

        # Get maximum number of rows required
        max_rows = max(len(transcription_factor_counter), len(comparison_counter), len(combination_counter))

        # Convert dictionary items to list
        tf_items = list(transcription_factor_counter.items())
        comparison_items = list(comparison_counter.items())
        combination_items = list(combination_counter.items())

        # Write data rows
        for i in range(max_rows):
            tf_name, tf_count = tf_items[i] if i < len(tf_items) else ('', '')
            comparison_name, comparison_count = comparison_items[i] if i < len(comparison_items) else ('', '')
            combination_name, combination_count = f"{combination_items[i][0][0]}-{combination_items[i][0][1]}" if i < len(combination_items) else '', combination_items[i][1] if i < len(combination_items) else ''

            writer.writerow([tf_name, tf_count, comparison_name, comparison_count, combination_name, combination_count])

def main():
    # File path
    input_path = 'subset_z.tsv'
    output_path = 'output.tsv'

    # Read the TSV file
    with open(input_path, 'r') as f:
        data = list(csv.DictReader(f, delimiter='\t'))

    transcription_factor_counter, comparison_counter, combination_counter = count_elements(data)

    # Write results to TSV
    write_to_tsv(transcription_factor_counter, comparison_counter, combination_counter, output_path)

if __name__ == "__main__":
    main()
