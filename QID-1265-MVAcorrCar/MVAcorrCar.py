import numpy as np

# Generating data (X3 vs X4)
r = 5
c = 5
X3x4  = [1, 1, 0, 0, 0, 0, 7, 1, 0, 0, 2, 2, 19, 5, 0, 0, 0, 6, 11, 0, 0, 1, 1, 4, 5]
X3x4 = np.reshape(X3x4, (r, c))
rowst = np.sum(X3x4, axis = 1)
colst = np.sum(X3x4, axis = 0)
n = X3x4.sum()

# Expected values under independence (X3 vs. X4)
E = np.reshape(np.array([0.0]*(r*c)), (r, c))
for i in range(0, r):
    for j in range(0, c):
        E[i, j] = rowst[i] * colst[j]/n
        
# Chi-Square test statistic (X3 vs. X4)
Chi2_X3X4 = ((E - X3x4)**2/E).sum()
print(Chi2_X3X4)


# Generating data (X3 vs X13)
r = 5
c = 3   
X3x13 = [2, 0, 0, 8, 0, 0, 26, 0, 2, 8, 5, 4, 2, 6, 3]
X3x13 = np.reshape(X3x13, (r, c))
rowst = np.sum(X3x13, axis = 1)
colst = np.sum(X3x13, axis = 0)
n = X3x13.sum()

# Expected values under independence (X3 vs. X13)
E = np.reshape(np.array([0.0]*(r*c)), (r, c))
for i in range(0, r):
    for j in range(0, c):
        E[i, j] = rowst[i] * colst[j]/n
        
# Chi-Square test statistic (X3 vs. X13)
Chi2_X3X13 = ((E - X3x13)**2/E).sum()
print(Chi2_X3X13)


# Generating data (X4 vs X13)
r = 5
c = 3   
X4x13 = [2, 0, 1, 10, 0, 1, 21, 1, 5, 13, 5, 2, 0, 5, 0]
X4x13 = np.reshape(X4x13, (r, c))
rowst = np.sum(X4x13, axis = 1)
colst = np.sum(X4x13, axis = 0)
n = X4x13.sum()

# Expected values under independence (X3 vs. X13)
E = np.reshape(np.array([0.0]*(r*c)), (r, c))
for i in range(0, r):
    for j in range(0, c):
        E[i, j] = rowst[i] * colst[j]/n
        
# Chi-Square test statistic (X3 vs. X13)
Chi2_X4X13 = ((E - X4x13)**2/E).sum()
print(Chi2_X4X13)