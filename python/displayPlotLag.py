from datetime import datetime
from typing import Dict

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import dates
import os

# Créer le dossier 'output' s'il n'existe pas déjà
if not os.path.exists('output'):
    os.makedirs('output')

def readPanda():
    # data = pd.read_csv('reb82.txt')
    font = {'family': 'verdana',
            'weight': 'bold',
            'size': 8}
    plt.rc('font', **font)

    ## change this to your csv file.
    data = pd.read_csv('Lag.csv', parse_dates=['@timestamp'], date_parser=lambda x: pd.to_datetime(x, format='%b %d, %Y @ %H:%M:%S.%f'))

    data = data.iloc[::-1].reset_index()
    print(data['message'])
    print(data['kubernetes.pod.name'])
    data['message'] = data['message'].str.extract('total lag (\\d+)')
    print(data['message'])
    data['message'] = data['message'].astype(float)

    print(data['message'])

    # Calculer la différence de temps par rapport à la première observation
    start_time = data['@timestamp'].min()
    data['time_diff'] = (data['@timestamp'] - start_time).dt.total_seconds()

    fig, ax = plt.subplots()
    plt.xticks(rotation=45, ha='right')
    your_counter = len(data[data['message'] > 500])
    print(your_counter)

    # Votre code existant pour le traçage du graphique
    ax.set_xlabel("Time (sec)", **font)
    ax.set_ylabel("lag (ms)", **font)
    ax.plot(data['time_diff'], data['message'])

    # Supprimer l'ancienne image s'il existe
    if os.path.exists('output/read_panda_plot_lag.png'):
        os.remove('output/read_panda_plot_lag.png')

    # Enregistrer le plot comme un fichier PNG dans le dossier 'output'
    plt.savefig('output/read_panda_plot_lag.png')
    plt.close()


if __name__ == '__main__':
    readPanda()
