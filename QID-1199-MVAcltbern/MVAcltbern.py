from numpy import random
from math import sqrt
from sklearn.neighbors import KernelDensity
from scipy.stats import norm
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

p = 0.5
n = 35

# Random generation of the binomial distribution with parameters 1000*n and 0.5
bsample = random.binomial(1, p=0.5, size=1)
arr = np.array([random.binomial(1, p=0.5, size=1) for i in range(n*1000)]) # Create a matrix of binomial random variables
bsamplem = np.resize(arr,(n, 1000))
bsamplemstd = (np.mean(bsamplem, axis = 0) - p) / (sqrt(p * (1 - p)/n)) # Standardize

# Plot
plt.figure(figsize=(20,10))
plt.xlim([-4,4])
x = np.arange(-4, 4, 0.1)
plt.plot(x, norm.pdf(x,0,1), linewidth=4.0, c = "b")
pd.Series(bsamplemstd).plot(kind='density', linewidth=4.0, c = 'r')
plt.xlabel("1000 Random Samples", fontsize=20)
plt.ylabel("Estimated and Normal Density", fontsize=20)
plt.ylim(0, 0.45)
plt.title("Asymptotic Distribution, n = {}".format(n), fontsize=25)
plt.show()
