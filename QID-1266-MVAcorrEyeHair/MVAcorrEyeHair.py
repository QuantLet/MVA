import numpy as np

# Generating data
r = 4
c = 4
X = [68, 119, 26, 7, 15, 54, 14, 10, 5, 29, 14, 16, 20, 84, 17, 94]
X = np.reshape(np.array(X), (r, c))
rowst = X.sum(axis = 1)
colst = X.sum(axis = 0)
n = X.sum()

E = np.reshape(np.array([0.0]*(r*c)), (r, c))
for i in range(0, r):
    for j in range(0, c):
        E[i, j] = rowst[i] * colst[j]/n

# Chi-Squared test statistic
Chi2 = ((E-X)**2/E).sum()

print(Chi2)



