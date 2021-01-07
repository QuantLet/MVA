import numpy as np
import matplotlib.pyplot as plt

x = np.array([[3, 2], [2, 7], [1, 3], [0.37, 4.36], [10, 4]])
brands = ["Mercedes", "Jaguar", "Ferrari Init", "Ferrari New", "VW"]


fig, ax = plt.subplots(figsize = (7, 7))
ax.scatter(x[:, 0], x[:, 1], c = "r")
for i in range(0, len(x)):
    ax.text(x[i, 0]+0.05, x[i, 1]+0.1, brands[i], fontsize = 14)
ax.plot(x[2:4, 0], x[2:4, 1], c = "r")

plt.xlim(0, 12)
plt.ylim(0, 8)

plt.title("First iteration for Ferrari", fontsize = 16)
plt.show()