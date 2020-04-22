import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import statsmodels.api as sm
from KDEpy import FFTKDE

# load data
x = pd.read_csv("bank2.dat", sep = "\s+", header=None)
x1 = x.iloc[0:100, 5]
x2 = x.iloc[100:200, 5]

# Compute kernel density estimate
fh1_x, fh1_y = FFTKDE(bw="silverman", kernel='biweight').fit(np.array(x1)).evaluate()
fh2_x, fh2_y = FFTKDE(bw="silverman", kernel='biweight').fit(np.array(x2)).evaluate()

fig, ax = plt.subplots(figsize=(10,10))
ax.plot(fh1_x, fh1_y, c="black")
ax.plot(fh2_x, fh2_y, c="red", ls=":")
plt.xlim(137, 143)
plt.xlabel("Counterfeit                             /                                   Genuine")
plt.ylabel("Density estimates for diagonals")
plt.title("Swiss bank notes")

plt.show()

