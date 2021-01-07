import numpy as np
import matplotlib.pyplot as plt

x = np.array([[3, 2, 1, 10], [2, 7, 3, 4]]).T

d = np.zeros([len(x), len(x)])

for i in range(0, len(x)):
    for j in range(0, len(x)):
        d[i, j] = np.linalg.norm(x[i, :] - x[j, :])

f1 = [1, d[1, 2]]
f2 = [2, d[0, 2]]
f3 = [3, d[0, 1]]
f4 = [4, d[1, 3]]
f5 = [5, d[0, 3]]
f6 = [6, d[2, 3]]

y = [d[1, 2], d[0, 2], d[0, 1], d[1, 3], d[0, 3], d[2, 3]]
labels = ["(2,3)", "(1,3)", "(1,2)", "(2,4)", "(1,4)", "(3,4)"]



fig, ax = plt.subplots(figsize = (7, 7))
ax.plot(range(1, 7), y, c = "k")
ax.scatter(range(1, 7), y)
for i in range(0, 6):
    ax.text(i+1 +0.05, y[i] +0.1, labels[i], fontsize = 14, c = "r")

plt.xlim(0, 7)
plt.ylim(0, 10)

plt.xlabel("Dissimilarity")
plt.ylabel("Distance")

plt.title("Dissimilarities and Distances")
plt.show()