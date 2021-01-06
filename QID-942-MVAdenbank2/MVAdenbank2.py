import pandas as pd
import numpy as np
from KDEpy import FFTKDE
import matplotlib.pyplot as plt

x = pd.read_csv("bank2.dat", sep = "\s+", header=None)

x4 = x.iloc[:100, 3]
x5 = x.iloc[:100, 4]

f4_x, f4_y = FFTKDE(bw="silverman", kernel='gaussian').fit(np.array(x4)).evaluate()
f5_x, f5_y = FFTKDE(bw="silverman", kernel='gaussian').fit(np.array(x5)).evaluate()

fig, axes = plt.subplots(1, 2, figsize = (15, 10))
axes[0].plot(f4_x, f4_y)
axes[0].set_xlabel("Lower Inner Frame (X4)", fontsize = 15)
axes[0].set_ylabel("Density", fontsize = 15)
axes[0].set_title("Swiss bank notes", fontsize = 20)
axes[1].plot(f5_x, f5_y)
axes[1].set_xlabel("Upper Inner Frame (X5)", fontsize = 15)
axes[1].set_ylabel("Density", fontsize = 15)
axes[1].set_title("Swiss bank notes", fontsize = 20)
plt.show()