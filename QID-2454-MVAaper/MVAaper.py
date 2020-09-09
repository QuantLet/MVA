import pandas as pd
import numpy as np

x = pd.read_csv("bank2.dat", sep = "\s+", header=None)
xg = x[:100]
xf = x[100:200]

mg = xg.mean(axis = 0)
mf = xf.mean(axis = 0)
m = (mf + mg)/2
s = (99 * xg.cov() + 99 * xf.cov())/198
alpha = np.linalg.inv(s) @ (mg - mf)

miss1 = 0
for i in range(0, len(xg.iloc[:, 0])):
    if ((xg.iloc[i,:] - m) @ alpha) < 0:
        miss1 += 1

miss2 = 0
for i in range(0, len(xf.iloc[:, 0])):
    if ((xf.iloc[i,:] - m) @ alpha) > 0:
        miss2 += 1

aper = (miss1 + miss2)/len(x.iloc[:, 0])

print("Genuine banknotes classified as forged: {}".format(miss1))
print("Forged banknotes classified as genuine: {}".format(miss2))
print("APER (apparent error rate): {}".format(aper))