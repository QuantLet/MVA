#works on pandas 1.5.3, numpy 1.24.3 and scipy 1.10.1
import numpy as np
import pandas as pd
from scipy.stats import f

x = pd.read_table("bostonh.dat", sep='\s+', header=None)

# Transformations
x.iloc[:, 0] = np.log(x.iloc[:, 0])
x.iloc[:, 4] = np.log(x.iloc[:, 4])
x.iloc[:, 7] = np.log(x.iloc[:, 7])
x.iloc[:, 10] = np.exp(0.4 * x.iloc[:, 10]) / 1000
x.iloc[:, 12] = np.sqrt(x.iloc[:, 12])

data = pd.DataFrame(x)
v1 = x[x.iloc[:, 13] <= np.median(x.iloc[:, 13])]
v2 = x[x.iloc[:, 13] > np.median(x.iloc[:, 13])]
x1 = v1.iloc[:, [0, 4, 7, 10, 12]] 
x2 = v2.iloc[:, [0, 4, 7, 10, 12]] 
n1 = len(x1)
n2 = len(x2)
n = n1 + n2
p = x1.shape[1]

# Estimating the mean and the variance
s1 = ((n1 - 1) / n1) * np.cov(x1.T)
s2 = ((n2 - 1) / n2) * np.cov(x2.T)
s = (n1 * s1 + n2 * s2) / (n1 + n2)
ex1 = np.mean(x1, axis=0)
ex2 = np.mean(x2, axis=0)
sinv = np.linalg.inv(s)
k = n1 * n2 * (n - p - 1) / (p * (n**2))

# Computing the test statistic
f_statistic = k * np.dot(np.dot((ex1 - ex2).T, sinv), (ex1 - ex2))
print("F-statistic")
print(np.round(f_statistic, 3))

# Computing the critical value
crit_value = f.ppf(0.95, p, n - p - 1)
print("Critical value")
print(np.round(crit_value, 3))

# Computing the simultaneous confidence intervals

deltau = (ex1 - ex2) + np.sqrt(f.ppf(0.95, p, n - p - 1) * (1 / k) * np.diag(s))
deltal = (ex1 - ex2) - np.sqrt(f.ppf(0.95, p, n - p - 1) * (1 / k) * np.diag(s))

confint = np.column_stack((deltal, deltau))

print("Simultaneous confidence intervals")
print(np.round(confint, 4))
