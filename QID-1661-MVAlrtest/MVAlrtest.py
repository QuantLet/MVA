# works on numpy 1.24.3 and scipy 1.10.1
import numpy as np
from scipy.stats import chi2, f

x = np.loadtxt("pullover.dat")
y = x[:, 0]  # first column (sales)
n = len(y)  # number of observations
x = np.column_stack((np.ones_like(y), x[:, 1:4]))  # ones, second to fourth column
p = x.shape[1]  # number of parameters in beta

# MLE (LSE)
b = np.linalg.inv(x.T @ x) @ x.T @ y

aa = np.array([[0, 1, 0.5, 0]])  # matrix A
a = 0  # constant a
q = 1  # number of parameters in constr. beta

# Constrained MLE
bc = b - np.linalg.inv(x.T @ x) @ aa.T @ np.linalg.inv(aa @ np.linalg.inv(x.T @ x) @ aa.T) @ (aa @ b - a)

# LR test statistic
lrt1 = np.dot(y - np.dot(x, bc), y - np.dot(x, bc))
lrt2 = np.dot(y - np.dot(x, b), y - np.dot(x, b))
lrt = n * np.log(lrt1 / lrt2)

# Probability to reject hypothesis
p_value_chi2 = 1 - chi2.cdf(lrt, q)

# F test statistic
ft1 = np.dot((aa @ b - a), np.linalg.inv(aa @ np.linalg.inv(x.T @ x) @ aa.T)) @ (aa @ b - a).T
ft2 = lrt2
ft = ((n - p) / q) * ft1 / ft2

# Probability to reject hypothesis
p_value_f = 1 - f.cdf(ft, q, n - p)

print("Constrained MLE (bc):", np.round(bc, 3))
print("LR test statistic:", np.round(lrt, 3))
print("Probability to reject hypothesis (chi-square test):", np.round(p_value_chi2, 3))
print("F test statistic:", np.round(ft, 3))
print("Probability to reject hypothesis (F test):",  np.round(p_value_f, 3))
