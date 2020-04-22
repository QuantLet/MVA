import pandas as pd
import matplotlib.pyplot as plt

x = pd.read_csv("bank2.dat", sep = "\s+", header=None)

fig, ax = plt.subplots(figsize = (10, 10))
ax.boxplot([x.iloc[:100, 0], x.iloc[100:200, 0]], labels = ["GENUINE", "COUNTERFEIT"], 
           meanline = True, showmeans = True)
plt.title("Swiss Bank Notes")

plt.show()

