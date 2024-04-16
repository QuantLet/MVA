# works on numpy 1.23.5, matplotlib 3.6.2, statsmodels 0.13.5 and scipy 1.10.0
import numpy as np
import matplotlib.pyplot as plt
from statsmodels.distributions.copula.api import GumbelCopula
from scipy.stats import norm

copula = GumbelCopula(theta=3)
sample_gc = copula.rvs(10000)
sample_metagc = np.apply_along_axis(norm.ppf, axis=0, arr=sample_gc)

fig, ax = plt.subplots(1,1, figsize=(10,10))
ax.scatter(sample_metagc[:,0],sample_metagc[:,1])
ax.set_xlim(-4, 4)
ax.set_ylim(-4, 4)
fig.suptitle("Sample for fixed theta and sigma", fontsize = 25, y = 0.93)
ax.set_xlabel("u", fontsize = 22)
ax.set_ylabel("v", fontsize = 22)
ax.tick_params(axis='x', labelsize=18)
ax.tick_params(axis='y', labelsize=18)

plt.show()