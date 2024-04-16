#works on pandas 1.5.2, numpy 1.23.5 and matplotlib 3.7.0
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.lines as mlines
from pandas.plotting import parallel_coordinates

colnames = np.arange(1,14,1)
df = pd.read_table("carc.txt", names= colnames, header=None)
df.dropna(inplace = True)
df["name"] = df[13]
df = df.astype({3:'int64'})
for i in df.columns:
    df[i] = np.log(df[i])
    df[i] = (df[i]-np.min(df[i])) / np.ptp(df[i])


fig, ax = plt.subplots(figsize = (12,10))

parallel_coordinates(df, "name", linewidth ="0.9", color = ("red","blue","black"),
                     linestyle= "dashed", alpha = 0.8)
ax.tick_params(axis='both', labelsize=25)
ax.grid(False)
plt.title(label = "Parallel Coordinates Plot(Car Data)", 
          fontsize = 30, fontweight = "bold", pad = 15)

plt.legend([mlines.Line2D([], [], color="red", label= "US", linestyle= "dashed"),
            mlines.Line2D([], [], color="black", label= "Japan", linestyle= "dashed"),
            mlines.Line2D([], [], color="blue", label= "Europe", linestyle= "dashed")],
           ["US","Japan","Europe"], loc="lower center", 
           ncol=3, bbox_to_anchor=(0.5, -0.2), fontsize=25)
plt.show()
