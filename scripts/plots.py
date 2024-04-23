import pandas as pd
import matplotlib.pyplot as plt

import os
import sys

def process_log_files(file_path):
    try:
        data = pd.read_csv(file_path, sep='\t')
        print (f'Data loaded from {file_path}')
        return data
    except Exception as e:
        print (f'Error loading data: {e}')
        return pd.DataFrame()
    

def plot(data, title, ylabel, output_filename):
    plt.figure(figsize=(10,6))
    for column in data.columns[1:]:
        plt.plot(data['Epoch'], data[column], marker='o', label=column)
    plt.title(title)
    plt.xlabel('Epoch')
    plt.ylabel(ylabel)
    plt.legend()
    plt.grid(True)
    plt.savefig(output_filename)
    plt.close()
    print(f"Plot saved: {output_filename}")


def main(log_folder):
    log_files = [f for f in os.listdir(log_folder) if f.endswith('.log')]
    for file in log_files:
        file_path = os.path.join(log_folder, file)
        data = process_log_files(file_path)
        if not data.empty:
            plot(data, 'Training and Validation Perplexities', 'Perplexity',
                              os.path.join(log_folder, f'perplexities_{file.replace(".log", "")}.png'))


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print ('Use: python3 ./scripts/plots.py ./models')

    else:
        log_folder = sys.argv[1]
        main(log_folder)