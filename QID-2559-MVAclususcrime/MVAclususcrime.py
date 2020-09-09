import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


data = pd.read_csv("uscrime_python.csv", index_col = 0)

X = data.iloc[:, 2:9]

row_s = X.sum(axis = 1)
column_s = X.sum(axis = 0)
mat_s = X.values.sum()
D = np.array([[0]*50]*50)

D = pd.DataFrame(np.array([[0]*50]*50))

for i in range(0, len(X)):
    for j in range(i+1, len(X)-1):
            D.iloc[i, j] = 1/(column_s[6]/mat_s) * ((X.iloc[i, 6]/row_s[i]) - (X.iloc[j, 6]/row_s[j]))**2

