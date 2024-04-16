# works on pandas 1.5.2, numpy 1.23.5 and matplotlib 3.6.2
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# load the data
x = pd.read_table("pullover.dat", header=None, delim_whitespace=True)

y = x.iloc[:, 0]
x1 = x.iloc[:, 1]

b = np.polyfit(x1,y,1)

m1 = np.full((400, 1), y.mean())
xfit = (np.linspace(86,104,400)).reshape((-1, 1))
yfit = b[1] + xfit * b[0]
    
fig, ax = plt.subplots(figsize = (10, 10))
ax.scatter(x.iloc[:,1], x.iloc[:,0], c = "w", edgecolors = "black")
ax.plot(xfit,yfit, c = 'black')
ax.plot(xfit,m1, c = 'black', linestyle = "dashdot")
plt.xlim(88, 102)
plt.ylim(162, 198)
plt.xlabel("Price (X2)", fontsize = 14)
plt.ylabel("Sales (X1)", fontsize = 14)
plt.title("Pullovers Data", fontsize = 18)

for i in range(len(y)):         #Plotting the lines
    
    lx = np.full((100,1),x1[i])
    lym = np.linspace(y.mean(),y[i],100).reshape(-1, 1)
    ax.plot(lx,lym, c = 'r', linestyle = "dashed")
    
    lyr = np.linspace(y[i], b[1]+x1[i]*b[0], 100).reshape(-1,1)
    ax.plot(lx+0.2,lyr, c = 'b', linestyle = "dashed")
    
    lymr = np.linspace(y.mean(), b[1]+x1[i]*b[0], 100).reshape(-1,1)
    ax.plot(lx-0.2,lymr, c = 'g')

plt.show()