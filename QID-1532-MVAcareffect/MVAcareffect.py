#works on pandas 2.0.3, numpy 1.25.0, matplotlib 3.7.2 and statsmodels 0.14.0
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import statsmodels.api as sm
from statsmodels.formula.api import ols

carc = pd.read_table("carc.dat", header = None, sep = "\s+")
carc = carc.iloc[:,[2,8,11,13,1]]
carc.columns = ["Mileage", "Weight", "Displacement", "Origin", "Price"]

lm1 = ols(formula="np.log(Mileage) ~ np.log(Weight) + np.log(Displacement) + C(Origin)", data=carc).fit()
lm2 = ols(formula="np.log(Mileage) ~ np.log(Weight) + np.log(Displacement)", data=carc).fit()
anova_results = sm.stats.anova_lm(lm2, lm1)
print(anova_results)


fig, axs = plt.subplots(2,2, figsize=(9,7))
axs[0,0].scatter(np.log(carc["Weight"]),np.log(carc["Mileage"]))
axs[0,0].set_xlabel("log(Weight)")
axs[0,0].set_ylabel("log(Mileage)")
axs[0,1].scatter(np.log(carc["Displacement"]),np.log(carc["Mileage"]))
axs[0,1].set_xlabel("log(Displacement)")
axs[0,1].set_ylabel("log(Mileage)")
axs[1,0].boxplot([np.log(carc.loc[carc["Origin"] == 1, "Mileage"]), 
                  np.log(carc.loc[carc["Origin"] == 2, "Mileage"]),
                  np.log(carc.loc[carc["Origin"] == 3, "Mileage"])], labels = ["US", "Japan", "Europe"])
axs[1,1].scatter(np.log(carc["Weight"]),np.log(carc["Displacement"]))
axs[1,1].set_xlabel("log(Weight)")
axs[1,1].set_ylabel("log(Displacement)")
plt.show()


lm3 = ols(formula="np.log(Mileage) ~ np.log(Weight) + C(Origin)", data=carc).fit()
fig, ax = plt.subplots()
c3 = lm3.params
x = np.arange(7.4,8.6,0.01)

ax.scatter(np.log(carc.loc[carc["Origin"]==1, "Weight"]), np.log(carc.loc[carc["Origin"]==1, "Mileage"]), label = "US")
ax.scatter(np.log(carc.loc[carc["Origin"]==2, "Weight"]), np.log(carc.loc[carc["Origin"]==2, "Mileage"]), label = "Japan")
ax.scatter(np.log(carc.loc[carc["Origin"]==3, "Weight"]), np.log(carc.loc[carc["Origin"]==3, "Mileage"]), label = "Europe")
ax.plot(x, c3[0]+x*c3[3])
ax.plot(x, c3[0]+c3[1]+x*c3[3])
ax.plot(x, c3[0]+c3[2]+x*c3[3])
ax.set_xlabel("log(Weight)")
ax.set_ylabel("log(Mileage)")
fig.legend(loc=(0.75,0.73))
plt.show()