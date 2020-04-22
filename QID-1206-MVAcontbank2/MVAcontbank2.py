import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as st

# load data
xx = pd.read_csv("bank2.dat", sep = "\s+", header=None)

xx = xx.iloc[:,4:]

x_min=8.5
x_max=13
y_min=137.5
y_max=143

x_grid = np.mgrid[x_min:x_max:100j, y_min:y_max:100j][0]
y_grid = np.mgrid[x_min:x_max:100j, y_min:y_max:100j][1]

positions = np.array([x_grid.ravel(), y_grid.ravel()])
kernel = st.gaussian_kde(np.array([xx.iloc[:,0], xx.iloc[:,1]]), bw_method=1.06 * np.std(xx.iloc[:, 1]) * 200**(-1/5))
f = np.reshape(kernel(positions).T, x_grid.shape)

fig, ax = plt.subplots(figsize=(10,10))
ax.contourf(x_grid, y_grid, f, cmap="jet")
ax.imshow(np.rot90(f), cmap='jet', extent=[x_min, x_max, y_min, y_max])
g = ax.contour(x_grid, y_grid, f, colors='k')
ax.clabel(g, colors="black")
plt.title('Swiss bank notes')

plt.show()

