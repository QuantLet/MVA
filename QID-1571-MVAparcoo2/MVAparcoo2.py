import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

data = pd.read_csv("bank2.dat", sep = "\s+", header=None)

c = np.ravel([[1]*100, [2]*100])

y = (data - data.min())/(data.max() - data.min())
y.loc[:, 6] = c
y.columns = ["1", "2", "3", "4", "5", "6", "c"]



fig, ax = plt.subplots(figsize = (15, 10))
pd.plotting.parallel_coordinates(y, "c", color = ["black", "r"])
ax.legend().set_visible(False)
plt.title("Parallel coordinates plot (Bank data)")

plt.show()

