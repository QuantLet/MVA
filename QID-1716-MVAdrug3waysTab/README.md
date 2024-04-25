[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="1100" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAdrug3waysTab** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet: MVAdrug3waysTab

Published in: Applied Multivariate Statistical Analysis

Description: Presents the coefficient estimates based on the saturated model with first and second order interactions as well as the coefficient estimates for the restricted model with first interactions for the drug data. It also computes G-squared deviance and Chi-squared test statistics.

Keywords: contingency-table, chi-square, chi-square test, test, statistics, regression, hypothesis-testing

See also: MVAdrugLogistic, MVAdrug

Author: Awdesch Melzer
Author[Python]: Matthias Fengler, Tim Dass

Submitted: Fri, May 04 2012 by Dedy Dwi Prastyo 
Submitted[Python]: Tue, April 23 2024 by Tim Dass

Code warning: 
- 1: 'In sqrt(1/i) : NaNs produced'
- 2: 'In sqrt(1/i) : NaNs produced'

```

### PYTHON Code
```python

#works on  numpy 1.25.0, scipy 1.11.1 and statsmodels 0.14.0
import numpy as np
import statsmodels.api as sm
from scipy.stats import chi2

# Drug data
zi = np.array([
    [1, 0, 1, 0, 1, 0, 0, 0, 0, 21], [1, 0, 1, 0, 0, 1, 0, 0, 0, 32],
    [1, 0, 1, 0, 0, 0, 1, 0, 0, 70], [1, 0, 1, 0, 0, 0, 0, 1, 0, 43],
    [1, 0, 1, 0, 0, 0, 0, 0, 1, 19], [1, 0, 0, 1, 1, 0, 0, 0, 0, 683],
    [1, 0, 0, 1, 0, 1, 0, 0, 0, 596], [1, 0, 0, 1, 0, 0, 1, 0, 0, 705],
    [1, 0, 0, 1, 0, 0, 0, 1, 0, 295], [1, 0, 0, 1, 0, 0, 0, 0, 1, 99],
    [0, 1, 1, 0, 1, 0, 0, 0, 0, 46], [0, 1, 1, 0, 0, 1, 0, 0, 0, 89],
    [0, 1, 1, 0, 0, 0, 1, 0, 0, 169], [0, 1, 1, 0, 0, 0, 0, 1, 0, 98],
    [0, 1, 1, 0, 0, 0, 0, 0, 1, 51], [0, 1, 0, 1, 1, 0, 0, 0, 0, 738],
    [0, 1, 0, 1, 0, 1, 0, 0, 0, 700], [0, 1, 0, 1, 0, 0, 1, 0, 0, 847],
    [0, 1, 0, 1, 0, 0, 0, 1, 0, 336], [0, 1, 0, 1, 0, 0, 0, 0, 1, 196],
])

y = zi[:, 9]

# Design matrix
X = np.array([
    [1, 1, 1, 0, 0, 0], [1, 1, 0, 1, 0, 0], [1, 1, 0, 0, 1, 0], [1, 1, 0, 0, 0, 1],
    [1, 1, -1, -1, -1, -1], [1, -1, 1, 0, 0, 0], [1, -1, 0, 1, 0, 0], [1, -1, 0, 0, 1, 0],
    [1, -1, 0, 0, 0, 1], [1, -1, -1, -1, -1, -1], [-1, 1, 1, 0, 0, 0], [-1, 1, 0, 1, 0, 0],
    [-1, 1, 0, 0, 1, 0], [-1, 1, 0, 0, 0, 1], [-1, 1, -1, -1, -1, -1],
    [-1, -1, 1, 0, 0, 0], [-1, -1, 0, 1, 0, 0], [-1, -1, 0, 0, 1, 0], [-1, -1, 0, 0, 0, 1],
    [-1, -1, -1, -1, -1, -1],
])

# First order interactions
X1 = np.hstack([X, X[:, [0]] * X[:, [1]], X[:, [0]] * X[:, [2]], X[:, [0]] * X[:, [3]], X[:, [0]] * X[:, [4]], X[:, [0]] * X[:, [5]],
                X[:, [1]] * X[:, [2]], X[:, [1]] * X[:, [3]], X[:, [1]] * X[:, [4]], X[:, [1]] * X[:, [5]]])

# Second order interactions
X2 = np.hstack([X1, X[:, [0]] * X[:, [1]] * X[:, [2]], X[:, [0]] * X[:, [1]] * X[:, [3]], X[:, [0]] * X[:, [1]] * X[:, [4]], X[:, [0]] * X[:, [1]] * X[:, [5]]])

X3 = np.hstack([np.ones((X2.shape[0], 1)), X2])

# saturated model
b0 = np.linalg.solve(X3.T @ X3, X3.T @ np.log(y))
loglik1 = np.sum((X3 @ b0) * y)

# restricted model
nn1, nn2 = X1.shape
XX = np.column_stack((np.ones(nn1),X1))
nn1, nn2 = XX.shape
df = nn1 - nn2

fit = sm.GLM(y, XX, family=sm.families.NegativeBinomial()).fit()
b = fit.params
loglik2 = np.sum((XX @ b) * y)

lnyfit = XX @ b
yfit = np.exp(lnyfit)
e = np.log(y) - lnyfit

G2 = 2 * np.sum(y * e)
pvalG2 = 1 - chi2.cdf(G2, df)
X2 = np.sum(((y - yfit)**2) / yfit)
pvalX2 = 1 - chi2.cdf(X2, df)

statstable = np.array([[G2, pvalG2, X2, pvalX2, df]])
print("Statistics: G2 | pvalue | chisq| pvalue | degrees of freedom")
print(statstable)

print(" ")
print(" observed fitted")
print(" values   values")
print(np.column_stack((y, yfit)))


```

automatically created on 2024-04-25

### R Code
```r


# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("MASS")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# Drug data
zi = rbind(c(1, 0, 1, 0, 1, 0, 0, 0, 0, 21), c(1, 0, 1, 0, 0, 1, 0, 0, 0, 32), c(1, 
    0, 1, 0, 0, 0, 1, 0, 0, 70), c(1, 0, 1, 0, 0, 0, 0, 1, 0, 43), c(1, 0, 1, 0, 
    0, 0, 0, 0, 1, 19), c(1, 0, 0, 1, 1, 0, 0, 0, 0, 683), c(1, 0, 0, 1, 0, 1, 0, 
    0, 0, 596), c(1, 0, 0, 1, 0, 0, 1, 0, 0, 705), c(1, 0, 0, 1, 0, 0, 0, 1, 0, 295), 
    c(1, 0, 0, 1, 0, 0, 0, 0, 1, 99), c(0, 1, 1, 0, 1, 0, 0, 0, 0, 46), c(0, 1, 1, 
        0, 0, 1, 0, 0, 0, 89), c(0, 1, 1, 0, 0, 0, 1, 0, 0, 169), c(0, 1, 1, 0, 0, 
        0, 0, 1, 0, 98), c(0, 1, 1, 0, 0, 0, 0, 0, 1, 51), c(0, 1, 0, 1, 1, 0, 0, 
        0, 0, 738), c(0, 1, 0, 1, 0, 1, 0, 0, 0, 700), c(0, 1, 0, 1, 0, 0, 1, 0, 
        0, 847), c(0, 1, 0, 1, 0, 0, 0, 1, 0, 336), c(0, 1, 0, 1, 0, 0, 0, 0, 1, 
        196))
y = zi[, 10]

# Design matrix
I = 2  # sex M - F
J = 2  # drug Yes - No
K = 5  # age category 16-29, 30-44, 45-64, 65-74, 75++

X = rbind(c(1, 1, 1, 0, 0, 0), c(1, 1, 0, 1, 0, 0), c(1, 1, 0, 0, 1, 0), c(1, 1, 
    0, 0, 0, 1), c(1, 1, -1, -1, -1, -1), c(1, -1, 1, 0, 0, 0), c(1, -1, 0, 1, 0, 
    0), c(1, -1, 0, 0, 1, 0), c(1, -1, 0, 0, 0, 1), c(1, -1, -1, -1, -1, -1), c(-1, 
    1, 1, 0, 0, 0), c(-1, 1, 0, 1, 0, 0), c(-1, 1, 0, 0, 1, 0), c(-1, 1, 0, 0, 0, 
    1), c(-1, 1, -1, -1, -1, -1), c(-1, -1, 1, 0, 0, 0), c(-1, -1, 0, 1, 0, 0), c(-1, 
    -1, 0, 0, 1, 0), c(-1, -1, 0, 0, 0, 1), c(-1, -1, -1, -1, -1, -1))

n   = dim(X)
n1  = n[1]
n2  = n[2]

# First order interactions
X1  = cbind(X, X[, 1] * X[, 2], X[, 1] * X[, 3], X[, 1] * X[, 4], X[, 1] * X[, 5], 
    X[, 1] * X[, 6], X[, 2] * X[, 3], X[, 2] * X[, 4], X[, 2] * X[, 5], X[, 2] * 
        X[, 6])

# Second order interactions
X2  = cbind(X1, X[, 1] * X[, 2] * X[, 3], X[, 1] * X[, 2] * X[, 4], X[, 1] * X[, 2] * 
    X[, 5], X[, 1] * X[, 2] * X[, 6])

# Constant term
X3  = cbind(rep(1, n1), X2)

nn  = dim(X3)
nn1 = nn[1]
nn2 = nn[2]

# saturated model
(df     = nn1 - nn2)
(b0     = solve(t(X3) %*% X3) %*% t(X3) %*% log(y))
(loglik = sum((X3 %*% b0) * y))

# restricted model
nn  = dim(X1)
nn1 = nn[1]
nn2 = nn[2]

XX  = cbind(rep(1, nn1), X1)
nn  = dim(XX)
nn1 = nn[1]
nn2 = nn[2]
(df = nn1 - nn2)

#standard parameters produce warnings
#fit = glm.nb(y ~ X1)

# This is ok
fit = glm.nb(y ~ X1, control=glm.control(maxit=200, epsilon = 1e-6))
b   = fit$coefficients
cbind(b)
(loglik = sum((XX %*% b) * y))

lnyfit  = XX %*% b
yfit    = exp(lnyfit)
e       = log(y) - lnyfit
print("degree of freedom")
print(df)

G2      = 2 * sum(y * e)
pvalG2  = 1 - pchisq(G2, df)
X2      = sum(((y - yfit)^2)/yfit)
pvalG2  = 1 - pchisq(G2, df)

statstable = cbind(G2, pvalG2, X2, pvalG2, df)
print("Statistics: G2 | pvalue | chisq| pvalue | degrees of freedom")
print(statstable)

print(" ")
print(" observed fitted")
print(" values   values")
print(cbind(y, yfit))
print(" ") 

```

automatically created on 2024-04-25