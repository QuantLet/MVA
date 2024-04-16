# works on numpy 1.24.3, scipy 1.10.1, statsmodels 0.14.0 and matplotlib 3.6.2
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm
from statsmodels.distributions.empirical_distribution import ECDF

n = [100,1000]
xx = np.arange(-3, 3, 0.01)
theoretical = norm.cdf(xx)

for i in n:
    fig, ax = plt.subplots(1,1, figsize=(10,10))
    y = norm.rvs(size=i)
    y = ECDF(y)
    
    ax.plot(xx, theoretical, label="Theoretical", c = "r", lw = 3)
    ax.step(y.x, y.y, label="Empirical", c = "b")
    fig.suptitle("EDF and CDF", fontsize = 25, y = 0.93)
    ax.set_xlim(-3, 3)
    ax.set_ylim(0, 1)
    ax.set_xlabel("X", fontsize = 22)
    ax.set_ylabel("EDF(X), CDF(X)", fontsize = 22)
    ax.tick_params(axis='x', labelsize=18)
    ax.tick_params(axis='y', labelsize=18)
    fig.legend(loc =(0.15, 0.8), fontsize = 22)
    
plt.show()