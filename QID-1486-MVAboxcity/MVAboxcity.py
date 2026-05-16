import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

x = pd.read_csv('cities.txt', sep=" ", header=None)
m1 = x.mean()

fig, ax = plt.subplots(figsize=(10, 10))

# Make figure and axes transparent
fig.patch.set_alpha(0.0)  # Transparent figure background
ax.patch.set_alpha(0.0)   # Transparent axes background

# Create boxplot with transparent elements
bp = ax.boxplot(x[0], patch_artist=True,
                boxprops=dict(facecolor="lightgrey", alpha=0.4),  # Reduced alpha for more transparency
                medianprops=dict(color="black", linewidth=2.5, alpha=0.8),
                meanline=True, showmeans=True, 
                meanprops=dict(color="black", alpha=0.8), 
                widths=0.3)

# Make other plot elements transparent
ax.spines['top'].set_alpha(0.5)
ax.spines['bottom'].set_alpha(0.5)
ax.spines['left'].set_alpha(0.5)
ax.spines['right'].set_alpha(0.5)

ax.tick_params(axis='both', which='both', colors='black', labelcolor='black')  # Make tick labels and ticks transparent
ax.xaxis.label.set_alpha(0.7)  # Make x-label transparent
ax.yaxis.label.set_alpha(0.7)  # Make y-label transparent

ax.set_xlabel("World Cities", fontsize=15)
ax.set_ylabel("Values", fontsize=15)
plt.title("Boxplot", fontsize=20, alpha=0.8)  # Transparent title

five = np.quantile(x, [0.025, 0.25, 0.5, 0.75, 0.975])
print("Five number summary, in millions")
pd.DataFrame(data={"value": five}, index=["2.5%", "25%", "50%", "75%", "97.5%"]).T

plt.show()

# To save with transparent background:
# plt.savefig('boxplot_transparent.png', transparent=True, dpi=300)
