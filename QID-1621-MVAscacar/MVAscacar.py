import pandas as pd
import matplotlib.pyplot as plt

x = pd.read_csv('carc.txt', sep="\t", header=None)

M = x.iloc[:, 1]
W = x.iloc[:, 7]
C = x.iloc[:, 12]

fig, ax = plt.subplots(figsize = (10, 10))
ax.scatter(x[x.iloc[:, 12] == 1].iloc[:, 1], x[x.iloc[:, 12] == 1].iloc[:, 7], 
           c = "black", marker = "*")
ax.scatter(x[x.iloc[:, 12] == 2].iloc[:, 1], x[x.iloc[:, 12] == 2].iloc[:, 7], 
           c = "w", marker = "o", edgecolor = "r")
ax.scatter(x[x.iloc[:, 12] == 3].iloc[:, 1], x[x.iloc[:, 12] == 3].iloc[:, 7], 
           c = "b", marker = "+")
plt.xlabel("Mileage (X2)", fontsize = 14)
plt.ylabel("Weight (X8)", fontsize = 14)
plt.title("Car Data", fontsize = 14)
plt.show()