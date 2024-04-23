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

