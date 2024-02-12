
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import dates, patches
import matplotlib as mpl

import glob





def plotCDF():
    font = {'family': 'normal',
            'weight': 'bold',
            'size': 10}
    plt.rc('font', **font)
    txtfiles = []
    for file in glob.glob("plot/*.txt"):
    #for file in glob.glob("500/*.txt"):
    #for file in glob.glob("taillatency/*.txt"):
    #for file in glob.glob("500p/*.txt"):


        txtfiles.append(file)
        print(file)
    pandasData = []
    for i in range(len(txtfiles)):
        print(i)
        pandasDataa = pd.read_csv(txtfiles[i])
        pandasDataa =  pandasDataa.iloc[::-1].reset_index()
        pandasDataa[' text_payload'] = pandasDataa[' text_payload'].str.extract('latency is (\d+)')
        pandasDataa[' text_payload'] = pandasDataa[' text_payload'].astype(float)
        pandasDataa['timestamp'] = pd.to_datetime( pandasDataa['timestamp'])
        pandasData.append(pandasDataa)
    fig, ax = plt.subplots()
    ax.set_xlabel("Latency (ms)", **font)
    ax.set_ylabel("CDF", **font)
    for i in range(len(txtfiles)):
        pandasData[i][' text_payload'].hist(cumulative=True, density=1, bins=1000, alpha=1, grid=False,
                                            linewidth=1.5,histtype='step', fill = None, legend=True)
    fix_hist_step_vertical_line_at_end(ax)

    plt.legend(["Heartbeat = 3s", "heartbeat=500ms"])

    plt.show()




def fix_hist_step_vertical_line_at_end(ax):
    axpolygons = [poly for poly in ax.get_children() if isinstance(poly, mpl.patches.Polygon)]
    for poly in axpolygons:
        poly.set_xy(poly.get_xy()[:-1])



if __name__ == '__main__':
    plotCDF()
