#works on numpy 1.23.5 and matplotlib 3.6.2
import numpy as np
import matplotlib.pyplot as plt

np.random.seed(1)

mean = [0, 0]
cov = [[1, 0.8],
       [0.8, 1]]
x, y = np.random.multivariate_normal(mean, cov, size=150).T

fig, ax = plt.subplots(figsize = (10, 10))
ax.scatter(x, y, facecolors='none', edgecolors='black')
plt.xlabel("X", fontsize = 18)
plt.ylabel("Y", fontsize = 18)
plt.title("Normal Sample, n=150", fontsize = 23)
plt.xlim(-3, 3)
plt.ylim(-3, 3)
plt.show()
