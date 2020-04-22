import pandas as pd
import matplotlib.pyplot as plt

x = pd.read_csv("bank2.dat", sep = "\s+", header=None)


fig, ax = plt.subplots(figsize = (10, 10))
ax.boxplot([x.iloc[:100, 5], x.iloc[100:200, 5]], labels = ["GENUINE", "COUNTERFEIT"], 
           meanline = True, showmeans = True)
plt.title("Swiss Bank Notes")

plt.show()

