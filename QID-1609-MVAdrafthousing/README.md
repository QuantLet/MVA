[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="1100" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAdrafthousing** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet: MVAdrafthousing

Published in: Applied Multivariate Statistical Analysis

Description: Plots the scatterplot matrix for Boston housing data.

Keywords: financial, data visualization, boxplot, scatterplot, plot, graphical representation

See also: MVAdrafthousingt, MVApcphousing

Author: Vladimir Georgescu, Jorge Patron, Song Song, Julia Wandke, Awdesch Melzer
Author[Python]: Matthias Fengler, Tim Dass

Submitted: Tue, September 09 2014 by Awdesch Melzer
Submitted[Python]: Tue, April 16 2024 by Tim Dass

Datafile: bostonh.dat

```

![Picture1](MVAdrafthousing-python.png)

![Picture2](MVAdrafthousing.png)

### PYTHON Code
```python

#works on pandas 1.5.2, numpy 1.23.5 and matplotlib 3.6.2
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

df = pd.read_csv('bostonh.dat', sep='\s+', header=None, names=np.arange(1,15,1))

df["name"] = df[14]
df.loc[df["name"] <= df["name"].median(), ["name"]] = 1
df.loc[df["name"] > df["name"].median(), ["name"]] = 2
df = df.loc[:,[1,2,3,4,5,14,"name"]]
df.rename(columns={14: 6}, inplace= True)

fig, axs = plt.subplots(6,6, figsize=(20,20))

for i in range(6):
    for j in range(6):
        if i == j:
            axs[i,j].boxplot([df.loc[df["name"] == 1,i+1], df.loc[df["name"] == 2,i+1]],
                             widths = 0.6, medianprops = dict(color="black",linewidth=1.8))
            axs[i, j].plot([0.7, 1.3], [df.loc[df["name"] == 1, i+1].mean(), df.loc[df["name"] == 1, i+1].mean()], linestyle="dotted", linewidth=1.5, color="red")
            axs[i, j].plot([1.7, 2.3], [df.loc[df["name"] == 1, i+1].mean(), df.loc[df["name"] == 1, i+1].mean()], linestyle="dotted", linewidth=1.5, color="red")
            axs[i, j].set_xticks([])
            axs[i, j].set_yticks([])
        
        if i > j:    
            axs[i,j].scatter(df.loc[df["name"] == 1,j+1],df.loc[df["name"] == 1,i+1], 
                             alpha = 0.7, facecolors='none', edgecolors='k')
            axs[i,j].scatter(df.loc[df["name"] == 2,j+1],df.loc[df["name"] == 2,i+1], 
                             alpha = 0.7, facecolors='none', edgecolors='r')
            axs[i, j].set_xticks([])
            axs[i, j].set_yticks([])
        
        if j > i:
            axs[i, j].axis("off")
            
fig.suptitle("Scatterplot matrix for Boston Housing", fontsize=50, y=0.92)
plt.show()

```

automatically created on 2024-04-25

### R Code
```r


# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# load data
data = read.table("bostonh.dat")

K    = as.numeric(data[, 14] > median(data[, 14])) + 1
x    = cbind(data[, -(6:13)], K)
z    = data.frame(x)
z1   = subset(z, z$K == 1)
z2   = subset(z, z$K == 2)
m1   = apply(z1, 2, mean)
m2   = apply(z2, 2, mean)
i    = 0
op   = par(mfrow = c(6, 6), cex = 0.15)

while (i < 6) {
    i = i + 1
    j = 0
    while (j < 6) {
        j = j + 1
        
        if (i == j) {
            boxplot(x[, i] ~ K, at = 1:2, axes = FALSE, lwd = 0.7)
            lines(c(0.6, 1.4), c(m1[i], m1[i]), lty = "dotted", lwd = 1.2, col = "red3")
            lines(c(1.6, 2.4), c(m1[i], m1[i]), lty = "dotted", lwd = 1.2, col = "red3")
        }
        
        if (i > j) {
            yy = cbind(x[, j], x[, i], K)
            plot(yy[, -3], col = as.numeric(K), xlab = "", ylab = "", cex = 4, axes = FALSE)
        }
        
        if (i < j) {
            plot(i, type = "n", axes = FALSE, xlab = "", ylab = "", main = "")
        }
    }
}
title(main = list("Scatterplot matrix for Boston Housing", cex = 8), line = -16, 
    outer = TRUE) 

```

automatically created on 2024-04-25