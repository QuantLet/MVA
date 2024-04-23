#works on pandas 1.5.3 and statsmodels 0.14.0
import pandas as pd
import statsmodels.api as sm

data = pd.read_table("bankrupt.txt", sep="\s+", header=None, names = [1,2,3,4,5,6]) 
y = data.loc[:, 6]
X = sm.add_constant(data.loc[:,[3,4,5]])
fit = sm.Logit(y, X).fit()

print(fit.summary())