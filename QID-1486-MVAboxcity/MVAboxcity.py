import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

x = pd.read_csv('cities.txt', sep=" ", header=None)
m1 = x.mean()

fig, ax = plt.subplots(figsize = (10, 10))
ax.boxplot(x[0], patch_artist=True, boxprops=dict(facecolor = "lightgrey"), 
           medianprops=dict(color="black", linewidth = 2.5), meanline = True, 
           showmeans = True, meanprops=dict(color="black"), widths = 0.3)
ax.set_xlabel("World Cities", fontsize = 15)
ax.set_ylabel("Values", fontsize = 15)
plt.title("Boxplot", fontsize = 20)

five = np.quantile(x, [0.025, 0.25, 0.5, 0.75, 0.975])
print("Five number summary, in millions")
pd.DataFrame(data = {"value": five}, index = ["2.5%", "25%", "50%", "75%", "97.5%"]).T