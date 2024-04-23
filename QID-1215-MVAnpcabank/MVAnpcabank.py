#works on numpy 1.25.2, pandas 2.1.1 and matplotlib 3.8.0
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

x = pd.read_csv("bank2.dat", sep = "\s+", header=None)
x = (x-x.mean())/x.std()
cov_matrix = np.cov(x, rowvar=False)
e,v = np.linalg.eig(cov_matrix)
xv = np.dot(x,v)

fig, axs = plt.subplots(2,2, figsize=(10, 10))
axs[0, 0].scatter(xv[:100, 0], xv[:100, 1], edgecolor='r', marker='o', facecolors= 'w')
axs[0, 0].scatter(xv[100:, 0], xv[100:, 1], c='b', marker='+', s= 110)
axs[0, 0].set_title('First vs. Second PC')
axs[0, 0].set_xlabel('PC1')
axs[0, 0].set_ylabel('PC2')


axs[0, 1].scatter(xv[:100, 1], xv[:100, 2], edgecolor='r', marker='o', facecolors= 'w')
axs[0, 1].scatter(xv[100:, 1], xv[100:, 2], c='b', marker='+', s= 110)
axs[0, 1].set_title('Second vs. Third PC')
axs[0, 1].set_xlabel('PC2')
axs[0, 1].set_ylabel('PC3')


axs[1, 0].scatter(xv[:100, 0], xv[:100, 2], edgecolor='r', marker='o', facecolors= 'w')
axs[1, 0].scatter(xv[100:, 0], xv[100:, 2], c='b', marker='+', s= 110)
axs[1, 0].set_title('First vs. Third PC')
axs[1, 0].set_xlabel('PC1')
axs[1, 0].set_ylabel('PC3')


axs[1, 1].scatter(range(1,7), e, c='b')
axs[1, 1].set_title('Eigenvalues of S')
axs[1, 1].set_xlabel('Index')
axs[1, 1].set_ylabel('Lambda')

plt.show()