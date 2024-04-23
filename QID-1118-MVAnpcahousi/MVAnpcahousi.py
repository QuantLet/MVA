#works on numpy 1.25.2, pandas 2.1.1 and matplotlib 3.8.0
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.patches import Circle

df = pd.read_csv('bostonh.dat', sep='\s+', header=None, names=np.arange(1,15,1))

df2 = pd.DataFrame()
df2[[1,3,5,6,8,9,10,14]] = np.log(df[[1,3,5,6,8,9,10,14]])
df2[4] = df[4]
df2.loc[:,2] = df.loc[:,2]/10
df2.loc[:,7] = (pow(df.loc[:,7],2.5))/10000
df2.loc[:,11] = (np.exp(0.4*df.loc[:,11]))/1000
df2.loc[:,12] = df.loc[:,12]/100
df2.loc[:,13] = pow(df.loc[:,13],0.5)
df2 = df2[np.arange(1,15,1)]
df2.drop(columns=[4], inplace=True)

n1, n2 = df2.shape

x = (df2-df2.stack().mean())/(np.sqrt((n1-1) * np.var(df2, axis=0)/n1))

cov_matrix = np.cov(x, rowvar=False)
e, v = np.linalg.eig((n1-1) * cov_matrix/n1)
x1 = x - x.stack().mean()
r1 = np.dot(x1, v)
r = np.corrcoef(r1, x, rowvar=False)
r = r[n2:, :n2]
r12 = r[:,[0,1]]
r13 = r[:,[0,2]]
r32 = r[:,[2,1]]
r123 = r[:,[0,1,2]]

fig, ax = plt.subplots(2,2,figsize=(10,10))

names = [f'X{i}' for i in range(1, 15) if i != 4]

ax = ax.ravel()
for i in range(4):
    ax[i].plot([0,0],[-1,1], color='grey', alpha=0.5)
    ax[i].plot([-1,1],[0,0], color='grey', alpha=0.5)
    ax[i].set_ylim(-1,1)
    ax[i].set_xlim(-1,1)
    circle = Circle((0,0), 1, color='b', fill=False)
    ax[i].add_patch(circle)
    ax[i].set_xticks([-1,-0.5,0,0.5,1])
    ax[i].set_yticks([-1,-0.5,0,0.5,1]) 
    ax[i].set_aspect('equal')

ax[0].scatter(r12[:,0], r12[:,1])
for i, name in enumerate(names):
    ax[0].annotate(name, (r12[i,0], r12[i,1]))
ax[0].set_xlabel('first PC')
ax[0].set_ylabel('second PC')

ax[1].scatter(r13[:,0], r13[:,1])
for i, name in enumerate(names):
    ax[1].annotate(name, (r13[i,0], r13[i,1]))
ax[1].set_xlabel('first PC')
ax[1].set_ylabel('third PC')

ax[2].scatter(r32[:,0], r32[:,1])
for i, name in enumerate(names):
    ax[2].annotate(name, (r32[i,0], r32[i,1]))
ax[2].set_xlabel('third PC')
ax[2].set_ylabel('second PC')

ax[3].scatter(r123[:,0], r123[:,1])
for i, name in enumerate(names):
    ax[3].annotate(name, (r123[i,0], r123[i,1]))
ax[3].set_xlabel('X')
ax[3].set_ylabel('Y')

fig.suptitle('Boston Housing', y = 0.92)
plt.show()