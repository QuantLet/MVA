#works on pandas 1.5.2 and matplotlib 3.6.2
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_table("carc.txt", header=None)
df = df.iloc[:,[4,5,6]]

fig, ax = plt.subplots(figsize = (12,10))
ax.boxplot(df, widths = 0.7, labels = ["headroom","rear seat","trunk space"],
            whiskerprops = {'linestyle': '--', 'linewidth': '2'},
            capprops = {'linewidth': '2'}, capwidths = 0.5,
            boxprops = {'linewidth': '2'}, flierprops = {'linewidth':'2.5', 'color':'red'},
            meanline = True, showmeans = True)
ax.tick_params(axis='both', labelsize=25)
plt.title(label = "Boxplot (Car Data)", 
          fontsize = 30, fontweight = "bold", pad = 15)
