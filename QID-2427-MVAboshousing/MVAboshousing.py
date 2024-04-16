#works on pandas 2.0.3 and statsmodels 0.14.0
import pandas as pd
from statsmodels.formula.api import ols

df = pd.read_csv('bostonh.dat', sep='\s+', header=None, names=[f"X{i}" for i in range(1, 15)])

lm1 = ols(formula = "X14 ~ X4 + X5 + X6 + X8 + X9 + X10 + X11 + X12 + X13", data = df).fit()
print(lm1.summary())

med9 = df["X9"].median()
df["X15"] = [1 if i >= med9 else -1 for i in df["X9"]]
df["X4"] = [-1 if i == 0 else 1 for i in df["X4"]]

lm2 = ols(formula = "X14 ~ X4 + X5 + X6 + X8 + X10 + X11 + X12 + X13 + X15", data = df).fit()
print(lm2.summary())

lm3 = ols(formula = "X14 ~ X4 + X5 + X6 + X8 + X10 + X11 + X12 + X13 + X15 + X4*X12 + X4*X15", data = df).fit()
print(lm3.summary())