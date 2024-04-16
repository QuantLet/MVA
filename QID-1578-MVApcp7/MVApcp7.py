#works on pandas 1.5.2, numpy 1.23.5 and matplotlib 3.6.2
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pandas.plotting import parallel_coordinates

data = {"name":["A","B"],1:[0,3],2:[2,2],3:[3,2],4:[2,1]}
df = pd.DataFrame(data)

fig, ax = plt.subplots(figsize = (12,10))

parallel_coordinates(df, "name", color=("black"), linewidth ="1.7")
plt.legend().set_visible(False)
ax.tick_params(axis='both', labelsize = 25)
ax.set_xlabel("Coordinate", fontsize = 25)
ax.set_ylabel("Coordinate Value", fontsize = 25)
ax.yaxis.set_ticks(np.arange(0, 3.1, 1))
plt.title(label = "Parallel Coordinates Plot", 
          fontsize = 30, fontweight = "bold", pad = 15)
ax.grid(False)
plt.show()
