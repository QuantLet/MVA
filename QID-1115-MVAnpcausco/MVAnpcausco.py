#works on numpy 1.25.2, pandas 2.1.1 and matplotlib 3.8.0
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


x = pd.read_table("uscomp2.dat", sep="\s+", header = None)
x.columns = ["Company", "A", "S", "MV", "P", "CF", "E", "Sector"]
sector = x['Sector'].astype(str)
sector.iloc[0:2] = "H"
sector.iloc[2:17] = "E"
sector.iloc[17:34] = "F"
sector.iloc[34:42] = "H"
sector.iloc[42:52] = "M"
sector.iloc[52:63] = "*"
sector.iloc[63:73] = "R"
sector.iloc[73:79] = "*"

x = x.iloc[:,1:7]
n1, n2 = x.shape
x = (x-x.mean())/(np.sqrt((n1-1) * np.var(x, axis=0)/n1))

cov_matrix = np.cov(x, rowvar=False)
e, v = np.linalg.eig((n1-1) * cov_matrix/n1)
xv = np.dot(x, v)
xv[:,0] = xv[:,0] * (-1)

fig, ax = plt.subplots(figsize=(8,6))
ax.scatter(xv[:, 0], xv[:, 1], s = 2)
[ax.annotate(sector[i], (xv[i, 0], xv[i, 1])) for i in range(n1)]
ax.set_title('First vs. Second PC')
ax.set_xlabel('PC1')
ax.set_ylabel('PC2')
plt.show()

fig, ax = plt.subplots(figsize=(8, 6))
ax.scatter(np.arange(1,7,1), e)
ax.set_title('Eigenvalues of S')
ax.set_xlabel('Index')
ax.set_ylabel('Lambda')
plt.show()
