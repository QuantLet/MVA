[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="1100" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAsimcibh** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet: MVAsimcibh

Published in: Applied Multivariate Statistical Analysis

Description: Tests the equality of 2 groups of Boston Housing data and computes the F-statistic and the critical value of the test and the simultaneous confidence intervals.

Keywords: F-test, F-statistic, critical-value, confidence-interval, test, hypothesis-testing, financial

See also: MVAlinregbh, MVAdiscbh, MVAdescbh, MVAclusbh, MVAboxbhd, MVAaerbh

Author: Vladimir Georgescu, Song Song, Awdesch Melzer
Author[Python]: Matthias Fengler, Tim Dass

Submitted: Wed, April 04 2012 by Dedy Dwi Prastyo
Submitted[Python]: Tue, April 16 2024 by Tim Dass

Datafile: bostonh.dat

```

### PYTHON Code
```python

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

```

automatically created on 2024-04-25

### R Code
```r


# сlear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# load data
x = read.table("bostonh.dat")

# Transformations
x[, 1]  = log(x[, 1])
x[, 5]  = log(x[, 5])
x[, 8]  = log(x[, 8])
x[, 11] = exp(0.4 * x[, 11])/1000
x[, 13] = sqrt(x[, 13])

data = data.frame(x)
v1    = subset(x, x[, 14] <= median(x[, 14]))
v2    = subset(x, x[, 14] > median(x[, 14]))
x1    = cbind(v1[, 1], v1[, 5], v1[, 8], v1[, 11], v1[, 13])
x2    = cbind(v2[, 1], v2[, 5], v2[, 8], v2[, 11], v2[, 13])
n1    = length(x1[, 1])
n2    = length(x2[, 1])
n     = n1 + n2
a     = dim(x1)
p     = a[2]

# Estimating the mean and the variance
s1    = ((n1 - 1)/n1) * cov(x1)
s2    = ((n2 - 1)/n2) * cov(x2)
s     = (n1 * s1 + n2 * s2)/(n1 + n2)
ex1   = apply(x1, 2, mean)
ex2   = apply(x2, 2, mean)
sinv  = solve(s)
k     = n1 * n2 * (n - p - 1)/(p * (n^2))

# Computing the test statistic
f = k * t(ex1 - ex2) %*% sinv %*% (ex1 - ex2)
print("F-statistic")
print(f)

# Computing the critical value
critvalue = qf(0.95, 5, 500)
print("critical value")
print(critvalue)

# Computes the simultaneous confidence intervals
deltau = (ex1 - ex2) + sqrt(qf(0.95, p, n - p - 1) * (1/k) * diag(s))
deltal = (ex1 - ex2) - sqrt(qf(0.95, p, n - p - 1) * (1/k) * diag(s))

confint = cbind(deltal, deltau)
print("Simultaneous confidence intervals")
print(confint)

```

automatically created on 2024-04-25