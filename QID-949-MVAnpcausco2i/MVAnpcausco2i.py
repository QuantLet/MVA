#works on numpy 1.25.2, pandas 2.1.1 and matplotlib 3.8.0
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle

x = pd.read_table("uscomp2.dat", sep="\s+", header = None)
x.columns = ["Company", "A", "S", "MV", "P", "CF", "E", "Sector"]

x = x.drop([37,39])
x = x.reset_index(drop=True)

x = x.iloc[:,1:7]
n1, n2 = x.shape
x = (x-x.mean())/(np.sqrt((n1-1) * np.var(x, axis=0)/n1))

cov_matrix = np.cov(x, rowvar=False)
e, v = np.linalg.eig((n1-1) * cov_matrix/n1)
r1 = np.dot(x, v)
r = np.corrcoef(r1, x, rowvar=False)
r = r[n2:, :n2]
r12 = r[:,[0,1]]

fig, ax = plt.subplots(figsize=(8,6))
ax.scatter(np.arange(1,7,1), e)
ax.set_title('U.S. Company Data')
ax.set_xlabel('Index')
ax.set_ylabel('Lambda')
plt.show()

names = [f'X{i}' for i in range(1, 7)]
fig, ax = plt.subplots(figsize=(6,6))
ax.plot([0,0],[-1,1], color='grey', alpha=0.5)
ax.plot([-1,1],[0,0], color='grey', alpha=0.5)
ax.set_ylim(-1,1)
ax.set_xlim(-1,1)
circle = Circle((0,0), 1, color='b', fill=False)
ax.add_patch(circle)
ax.set_xticks([-1,-0.5,0,0.5,1])
ax.set_yticks([-1,-0.5,0,0.5,1])
ax.set_aspect('equal')
ax.scatter(r12[:,0], r12[:,1])
for i, name in enumerate(names):
    ax.annotate(name, (r12[i,0], r12[i,1]))
ax.set_xlabel('first PC')
ax.set_ylabel('second PC')
ax.set_title('U.S Company Data')
plt.show()