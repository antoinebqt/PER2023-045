import os

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import dates, patches
import matplotlib as mpl


# Créer le dossier 'output' s'il n'existe pas déjà
if not os.path.exists('output'):
    os.makedirs('output')

def plotCDF():
    font = {'family': 'verdana',
            'weight': 'bold',
            'size': 10}
    plt.rc('font', **font)

    pandasDataa = pd.read_csv('input/94h.txt', parse_dates=False)
    pandasDataa = pandasDataa.iloc[::-1].reset_index()
    pandasDataa[' text_payload'] = pandasDataa[' text_payload'].str.extract('latency is (\\d+)')
    pandasDataa[' text_payload'] = pandasDataa[' text_payload'].astype(float)
    pandasDataa['timestamp'] = pd.to_datetime(pandasDataa['timestamp'])
    fig, ax = plt.subplots()
    ax.set_xlabel("Latency (ms)", **font)
    ax.set_ylabel("CDF", **font)
    pandasDataa[' text_payload'].hist(cumulative=True, density=1, bins=1000, alpha=1, grid=False,
                                        linewidth=1.5, histtype='step', fill=None, legend=True)
    fix_hist_step_vertical_line_at_end(ax)

    plt.legend(["Heartbeat = 3s", "heartbeat=500ms"])

    # Supprimer l'ancienne image s'il existe
    if os.path.exists('output/1_cdf.png'):
        os.remove('output/1_cdf.png')

    # Enregistrer le plot comme un fichier PNG dans le dossier 'output'
    plt.savefig('output/1_cdf.png')
    plt.close()


def fix_hist_step_vertical_line_at_end(ax):
    axpolygons = [poly for poly in ax.get_children() if isinstance(poly, mpl.patches.Polygon)]
    for poly in axpolygons:
        poly.set_xy(poly.get_xy()[:-1])


if __name__ == '__main__':
    plotCDF()
