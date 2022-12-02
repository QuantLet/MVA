#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Dec  2 11:20:34 2022

@author: Raul Bag
"""

# !pip install ChernoffFace


from ChernoffFace import *
import numpy
import pandas as pd
import matplotlib.cm


data = pd.read_csv("bank2.dat", sep = "\s+", header=None)


obs_91_110 = data.iloc[90:110]
obs_91_110 = obs_91_110.dropna()
obs_91_110 = obs_91_110.to_numpy()

obs_91_110 = variables_rescale(obs_91_110)



# Make Chernoff faces
fig = chernoff_face(data=obs_91_110, 
                    titles=[str(x + 1) for x in range(90,110)],
                    n_columns=5,
                    figsize=(12,12),
                    long_face=False,
                    color_mapper=matplotlib.cm.tab20c_r, dpi=600)

# Display
fig.tight_layout()

matplotlib.pyplot.savefig('MVAfacebank10_python.png', format='png', dpi=600, transparent=True)
matplotlib.pyplot.show()