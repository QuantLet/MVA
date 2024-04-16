#works on pandas 1.5.2, numpy 1.23.5 and matplotlib 3.7.0
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

df = pd.read_csv('bostonh.dat', sep='\s+', header=None, names=np.arange(1,15,1))

med14 = df[14].median()
K = [2 if c > med14 else 1 for c in df[14]]

df_x = pd.DataFrame(data = {1: np.log(df[1]), 2: df[2], 3: df[3], 4: df[4],
                            5: np.log(df[5]), 14: np.log(df[14]), "K": K})

z1 = df_x[df_x["K"] == 1]
z2 = df_x[df_x["K"] == 2]
m1 = np.mean(z1, axis = 0)
m2 = np.mean(z2, axis = 0)

fig, axs = plt.subplots(6,6, figsize=(20,20))

for i in range(6):
    for j in range(6):
        if i == j:
            axs[i,j].boxplot([df_x[df_x["K"] == 1].iloc[:, i], df_x[df_x["K"] == 2].iloc[:, i]],
                             widths = 0.6, medianprops = dict(color="black",linewidth=1.8))
            axs[i, j].plot([0.7, 1.3], [m1.iloc[i], m1.iloc[i]], linestyle="dotted", linewidth=1.5, color="red")
            axs[i, j].plot([1.7, 2.3], [m1.iloc[i], m1.iloc[i]], linestyle="dotted", linewidth=1.5, color="red")
            axs[i, j].set_xticks([])
            axs[i, j].set_yticks([])
        
        if i > j:    
            axs[i,j].scatter(df_x[df_x["K"] == 1].iloc[:, j], df_x[df_x["K"] == 1].iloc[:, i],
                             alpha = 0.7, facecolors='none', edgecolors='black')
            axs[i,j].scatter(df_x[df_x["K"] == 2].iloc[:, j], df_x[df_x["K"] == 2].iloc[:, i], 
                             alpha = 0.7, facecolors='none', edgecolors='r')
            axs[i, j].set_xticks([])
            axs[i, j].set_yticks([])
        
        if j > i:
            axs[i, j].axis("off")
            
fig.suptitle("Scatterplot matrix for Boston Housing", fontsize=50, y=0.92)
plt.show()
