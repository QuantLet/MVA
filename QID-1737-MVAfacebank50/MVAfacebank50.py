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


def draw_faces(start, end, filename):
    obs_start_end = data.iloc[start:end]
    obs_start_end = obs_start_end.dropna()
    obs_start_end = obs_start_end.to_numpy()
    
    obs_start_end = variables_rescale(obs_start_end)
    
    # Make Chernoff faces
    fig = chernoff_face(data=obs_start_end, 
                        titles=[str(x + 1) for x in range(start,end)],
                        n_columns=10,
                        figsize=(12,12),
                        long_face=False,
                        color_mapper=matplotlib.cm.tab20c_r, dpi=600)
    
    # Display
    fig.tight_layout()
    
    matplotlib.pyplot.savefig(filename, format='png', dpi=600, transparent=True)
    matplotlib.pyplot.show()

draw_faces(0, 50, 'MVAfacebank50_python_1.png')
draw_faces(50, 100, 'MVAfacebank50_python_2.png')
draw_faces(100, 150, 'MVAfacebank50_python_3.png')
draw_faces(150, 200, 'MVAfacebank50_python_4.png')