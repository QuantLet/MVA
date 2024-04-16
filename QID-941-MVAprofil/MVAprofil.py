#works on pandas 1.5.3, numpy 1.24.3 and matplotlib 3.6.2
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pandas.plotting import parallel_coordinates

data = {"name":["Group 1","Group 2"],1:[2,1.5],2:[3,2],3:[4,1.5],4:[2.8,2],5:[3,2.2]}
df = pd.DataFrame(data)

fig, ax = plt.subplots(figsize = (12,10))

parallel_coordinates(df, "name", color = ("red", "blue"), linewidth ="2.5")
ax.tick_params(axis='both', labelsize = 25)
ax.set_xlabel("Treatment", fontsize = 25)
ax.set_ylabel("Mean", fontsize = 25)
ax.yaxis.set_ticks(np.arange(0, 5.1, 1))
ax.legend(fontsize = 20)
plt.title(label = "Population Profiles", 
          fontsize = 30, fontweight = "bold", pad = 15)
ax.grid(False)
plt.show()