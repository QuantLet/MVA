#works on pandas 1.5.2 and matplotlib 3.6.2
import pandas as pd
import matplotlib.pyplot as plt

# Load data
allbus = pd.read_csv("allbus.csv", sep=";", decimal=",")
allbus1 = allbus.iloc[:, [1,5]]

# Exclude invalid observations
allbus1 = allbus1[(allbus1['ALTER'] <= 100) & (allbus1['COMPUTER'] < 999)]

# Get ages and net income
ages = allbus1.iloc[:, 0]
computer = allbus1.iloc[:, 1]

#create plot
fig, ax = plt.subplots(figsize=(12,10))
hb = ax.hexbin(ages, computer, gridsize=30, cmap='Blues',
                edgecolors = 'black', mincnt = 1)
ax.set_title("Hexagon plot", fontweight = 'bold', fontsize = 30, pad = 15)
ax.set_xlabel("Age", fontsize = 25)
ax.set_ylabel("Computer time", fontsize = 25)
ax.tick_params(axis='both', labelsize=25)
cbar = fig.colorbar(hb, drawedges = True) 
cbar.ax.tick_params(labelsize=22)

plt.show()