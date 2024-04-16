# works on numpy 1.23.5, pandas 1.5.2, scipy 1.10.0 and matplotlib 3.6.2
import pandas as pd
import numpy as np
from scipy import stats
import matplotlib.pyplot as plt

x = pd.read_csv("bank2.dat", sep = "\s+", header=None)

x1 = x.iloc[:, 3]
y1 = x.iloc[:, 4]

n = len(x1)
bandwidth = 1.06 * x1.std() * n ** (-1 / 5)

kde1 = stats.gaussian_kde(np.array(x1).T, bw_method=bandwidth)
kde2 = stats.gaussian_kde(np.array(y1).T, bw_method=bandwidth)
kdejoint = stats.gaussian_kde(x.iloc[:, [3, 4]].T, bw_method=bandwidth)

xs, ys = np.mgrid[6:14:50j, 6:14:50j]
positions = np.vstack([xs.ravel(), ys.ravel()])

zs1 = kde1(xs.ravel()).reshape(xs.shape)
zs2 = kde2(ys.ravel()).reshape(ys.shape)
zs4 = zs1 @ zs2

zs3 = kdejoint(positions).reshape(xs.shape)

fig, axs = plt.subplots(1, 2, figsize=(20, 10), subplot_kw={'projection': '3d'})

axs[0].plot_surface(xs, ys, zs4, cmap='viridis')
axs[0].view_init(elev=20, azim=60)
axs[0].set_title('Product of Estimates', fontsize=25, y=0.98)

axs[1].plot_surface(xs, ys, zs3, cmap='viridis')
axs[1].view_init(elev=20, azim=60)
axs[1].set_title('Joint Estimates', fontsize=25, y=0.98)

plt.show()
