# tested under numpy 1.26.4, pandas 2.2.1, matplotlib 2.2.5, scikit-learn 1.4.1, group-lasso 1.5.0

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from group_lasso import LogisticGroupLasso

splice = pd.read_csv('splice.csv')
X = splice.iloc[:,1:8]
y = splice.iloc[:,0]
X_category = pd.get_dummies(X, dtype=int) # turn the factor variables into dummies

groups = np.repeat([1,2,3,4,5,6,7],4) # define groups (4 dummies per group)

lambda_values = np.logspace(-2, -1, 20)
coefs = np.zeros((len(lambda_values), len(X_category.columns)))

# fit the model for each value of lambda to track the coefficient paths
for i, reg in enumerate(lambda_values):
    model = LogisticGroupLasso(groups = groups, group_reg = reg, l1_reg = 0, 
                               scale_reg = "group_size", supress_warning = True, 
                               fit_intercept = True)
    model.fit(X_category, y)
    coefs[i, :] = model.coef_[:, 1] - model.coef_[:, 0]


plt.figure(figsize=(10, 6))
for i in range(coefs.shape[1]):
    plt.plot(lambda_values, coefs[:, i])

plt.gca().invert_xaxis()

plt.xscale('log')
plt.xlabel('Lambda')
plt.ylabel('Coefficients')
plt.title('Coefficient paths')
plt.show()
