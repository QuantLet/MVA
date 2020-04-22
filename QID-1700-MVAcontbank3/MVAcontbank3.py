import pandas as pd
import numpy as np
import scipy.stats as st
from mayavi import mlab

xx = pd.read_csv("bank2.dat", sep = "\s+", header=None)

d = st.gaussian_kde(np.array(xx.iloc[:, 3:]).T)

for i, j in zip(["x", "y", "z"], range(3, 6)):
    globals()[i+"_min"] = min(np.array(xx.iloc[:, j]))-1
    globals()[i+"_max"] = max(np.array(xx.iloc[:, j]))+1

xi, yi, zi = np.mgrid[x_min:x_max:30j, y_min:y_max:30j, z_min:z_max:30j]

coords = np.vstack([item.ravel() for item in [xi, yi, zi]]) 
density = d(coords).reshape(xi.shape)


figure = mlab.figure('DensityPlot', bgcolor = (1, 1, 1))

mlab.contour3d(xi, yi, zi, density, opacity=0.5)
mlab.title("Swiss bank notes", color = (0,0,0))
mlab.axes(extent = [x_min, x_max, y_min, y_max, z_min, z_max], 
          x_axis_visibility = False, y_axis_visibility= False, z_axis_visibility = False)
mlab.show()

