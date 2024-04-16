# works on numpy 1.24.3, scipy 1.10.1, statsmodels 0.14.0 and matplotlib 3.6.2
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm
from statsmodels.distributions.empirical_distribution import ECDF

n = 100
x = norm.rvs(size=100)
xs1 = x[np.floor(n * np.random.uniform(size=n)).astype(int)]
xs2 = x[np.floor(n * np.random.uniform(size=n)).astype(int)]
xx = ECDF(x)
xx1 = ECDF(xs1)
xx2 = ECDF(xs2)

fig, ax = plt.subplots(1,1, figsize=(10,10))
ax.step(xx.x,xx.y, label = 'edf', c = 'black', lw = 3, alpha = 0.8)
ax.step(xx1.x, xx1.y, 'b:', label = 'bootstrap edf 1', lw = 3)
ax.step(xx2.x, xx2.y, 'r:', label = 'bootstrap edf 2', lw = 3)
fig.suptitle("EDF and 2 bootstrap EDFs, n = 100", fontsize = 25, y = 0.93)
ax.set_xlim(-3, 3)
ax.set_ylim(0, 1)
ax.set_xlabel("X", fontsize = 22)
ax.set_ylabel("edfs", fontsize = 22)
ax.tick_params(axis='x', labelsize=18)
ax.tick_params(axis='y', labelsize=18)
fig.legend(loc =(0.63, 0.13), fontsize = 18)

plt.show()