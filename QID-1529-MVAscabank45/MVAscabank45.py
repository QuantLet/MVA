import pandas as pd
import matplotlib.pyplot as plt

x = pd.read_csv("bank2.dat", sep = "\s+", header=None)

fig, ax = plt.subplots(figsize = (10, 10))
ax.scatter(x.iloc[:,3], x.iloc[:,4], c = "w", edgecolors = "black")
plt.xlim(7, 13)
plt.ylim(7, 13)
plt.title("Swiss bank notes")
plt.show()