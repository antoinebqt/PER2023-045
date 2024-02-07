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
    data = pd.read_csv('94h.txt', parse_dates=False)

    data = data.iloc[::-1].reset_index()
    print(data[' text_payload'])
    print(data[' pod_name'])
    data[' text_payload'] = data[' text_payload'].str.extract('latency is (\\d+)')

    print(data[' text_payload'])
    data[' text_payload'] = data[' text_payload'].astype(float)

    print(data[' text_payload'])

    data['timestamp'] = pd.to_datetime(data['timestamp'])

    m = data['timestamp'].first_valid_index()
    datem = data['timestamp'][m]
    data['timestamp'] = (data['timestamp'] - datem)
    data['timestamp'] = data['timestamp'].dt.seconds
    fig, ax = plt.subplots()
    # ax.xaxis.set_major_formatter(dates.DateFormatter('%H:%M'))
    plt.xticks(rotation=45, ha='right')
    your_counter = len(data[data[' text_payload'] > 500])
    # your_counter2 = len(data[' text_payload'].where(data[' text_payload'] > 500))
    print(your_counter)
    # print(your_counter2)
    # data[' text_payload'].hist(bins=100)
    # data[' text_payload'].hist(cumulative=True, bins=200, density =1,  alpha=0.8)##hist(bins=100)
    ax.set_xlabel("Time (sec)", **font)
    ax.set_ylabel("latency (ms)", **font)
    ax.plot(data['timestamp'], data[' text_payload'])

    # Supprimer l'ancienne image s'il existe
    if os.path.exists('output/read_panda_plot_2.png'):
        os.remove('output/read_panda_plot_2.png')

    # Enregistrer le plot comme un fichier PNG dans le dossier 'output'
    plt.savefig('output/read_panda_plot_1.png')
    plt.close()


def getReplicasMinutes():
    data = pd.read_csv('94h.txt')
    data['timestamp'] = pd.to_datetime(data['timestamp'])

    # data = pd.read_csv('taxi/taxireb2s.txt')

    u = data[' pod_name'].unique()
    print(u)
    totalseconds = 0
    for i in range(len(u)):
        print(u[i])
        h = data[' pod_name'][data[' pod_name'] == u[i]].last_valid_index()
        m = data[' pod_name'][data[' pod_name'] == u[i]].first_valid_index()

        # h = data[' pod_name'].where(data[' pod_name'] == u[i]).last_valid_index()
        # m = data[' pod_name'].where(data[' pod_name'] == u[i]).first_valid_index()
        datem = data['timestamp'][m]
        dateh = data['timestamp'][h]
        print(datem)
        print(dateh)

        t = (datem - dateh).seconds

        print()
        # datetime_obj1 = datetime.strptime(
        #     str(datem)[0:-11], '%Y-%m-%dT%H:%M:%S')
        # datetime_obj2 = datetime.strptime(
        #     str(dateh)[0:-11], '%Y-%m-%dT%H:%M:%S')
        # t = (datetime_obj1 - datetime_obj2).seconds
        totalseconds += t
    # Écriture du résultat dans un fichier texte dans le dossier 'output'
    with open('output/replicas_minutes_1.txt', 'w') as f:
        f.write(str(totalseconds / 60))


def plotByPod():
    font = {'family': 'verdana',
            'weight': 'bold',
            'size': 8}
    plt.rc('font', **font)

    data = pd.read_csv('94h.txt')

    data = data.iloc[::-1].reset_index()

    print(data[' text_payload'])
    print(data[' pod_name'])
    data[' text_payload'] = data[' text_payload'].str.extract('latency is (\\d+)')
    data[' text_payload'] = data[' text_payload'].astype(float)
    data['timestamp'] = pd.to_datetime(data['timestamp'], format='mixed')
    groups = data.groupby(' pod_name')

    num_of_groups = len(groups.groups)
    print(num_of_groups)

    dfs = []

    fig, axs = plt.subplots(num_of_groups, 1, figsize=(30, 20), facecolor='w', edgecolor='k', sharex='all')
    fig.subplots_adjust(hspace=.5, wspace=.001)
    axs = axs if isinstance(axs, np.ndarray) else [axs]

    for ax in axs:
        ax.xaxis.set_major_formatter(dates.DateFormatter('%H:%M'))
        ax.tick_params(axis='x', rotation=45)

    for name, group in groups:
        dfs.append(group)

    for i in range(0, num_of_groups):
        axs[i].title.set_text("")
        axs[i].plot(dfs[i]['timestamp'], (dfs[i][' text_payload']))
        #axs[i].grid()
        #axs[i].xaxis.set_major_formatter(dates.DateFormatter('%H:%M'))
        #axs[i].xticks(rotation=45, ha='right')
        axs[i].set_ylabel("Consumer " + str(i), **font)

    # Supprimer l'ancienne image s'il existe
    if os.path.exists('output/plot_by_pod_1.png'):
        os.remove('output/plot_by_pod_1.png')

    # Enregistrer le plot comme un fichier PNG dans le dossier 'output'
    plt.savefig('output/plot_by_pod_1.png')
    plt.close()

    # for df in dfs:
    #  # print(df)
    #  # print(type(df))
    #  print(df)
    #  ax.plot(df['timestamp'], df[' text_payload'])
    #  plt.show()

    print("------------------------")
    print(dfs[0])


if __name__ == '__main__':
    # readPanda()
    # getReplicasMinutes()
    plotByPod()
