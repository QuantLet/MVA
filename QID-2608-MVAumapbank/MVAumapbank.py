# works on pandas 1.5.3, matplotlib 3.6.2 and umap-learn 0.5.3
import pandas as pd
import umap
import matplotlib.pyplot as plt

x = pd.read_csv("bank2.dat", sep = "\s+", header=None)
neighbours = [2, 3, 10, 12]
n_components = 2

fig, ax = plt.subplots(1, 4, figsize = (15,4))

for i, neighbour in enumerate(neighbours):

    reducer = umap.UMAP(
        n_neighbors=neighbour,
        n_components=n_components,
        random_state=42,
        init="random",
    )
    Y = reducer.fit_transform(x)
    ax[i].set_title("k=%d" % neighbour)

    ax[i].scatter(Y[:100,0], Y[:100,1], c = "w", edgecolor = "b")
    ax[i].scatter(Y[100:,0], Y[100:,1], c = "r", marker = "+")
   
plt.show()