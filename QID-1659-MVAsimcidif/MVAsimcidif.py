# works on numpy 1.24.3, pandas 1.5.3 and scipy 1.10.1
import pandas as pd
import numpy as np
from scipy.stats import f

x = pd.read_table("uscomp2.dat", sep="\s+", header = None)
yE = x.loc[x[7] == "Energy",]
yM = x.loc[x[7] == "Manufacturing",]

exE = np.mean(yE.iloc[:, 1:3], axis=0)
exM = np.mean(yM.iloc[:, 1:3], axis=0)

print("Mean group Energy of assets (V2) and sales (V3)")
print(np.round(exE, 3))

print("Mean group Manufacturing of assets (V2) and sales (V3)")
print(np.round(exM, 3))

# Estimating variance of the groups observations within the groups and overall
nE = len(yE)
nM = len(yM)
n = nE + nM

p = len(exE)
sE = ((nE - 1) / nE) * np.cov(yE.iloc[:, 1:3], rowvar=False)
sM = ((nM - 1) / nM) * np.cov(yM.iloc[:, 1:3], rowvar=False)

s = (nE * sE + nM * sM) / (nE + nM)
sinv = np.linalg.inv(s)
k = nE * nM * (n - p - 1) / (p * (n**2))

# Computing the test statistic
f_value = k * np.dot(np.dot((exE - exM).T, sinv), (exE - exM))

print("Test statistic (f-value):", np.round(f_value, 3))

crit_value = f.ppf(1 - 0.05, p, n - p - 1)
print("Critical value:", np.round(crit_value, 3))

# Computes the simultaneous confidence intervals
deltau = (exE - exM) + np.sqrt(f.ppf(1 - 0.05, p, n - p - 1) * (1 / k) * np.diag(s))
deltal = (exE - exM) - np.sqrt(f.ppf(1 - 0.05, p, n - p - 1) * (1 / k) * np.diag(s))

confit = np.column_stack((deltal, deltau))

print("Simultaneous confidence intervals:")
print(np.round(confit, 3))

