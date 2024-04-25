[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="1100" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAcontnorm** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml


Name of QuantLet: MVAcontnorm

Published in: Applied Multivariate Statistical Analysis

Description: 'Computes a scatterplot of a normal sample and the contour ellipses for mu =(3,2) and sigma = (1,-1.5)~(-1.5,4).'

Keywords: bivariate, graphical representation, contour, normal-distribution, plot, scatterplot

See also: MVAcontbank2, MVAdenbank2, MVAdenbank3, MVAscabank45, MVAscabank56, MVAscacar, MVAscapull1, MVAscapull2

Author: Franziska Schulz, Maria Osipenko
Author[Python]: Matthias Fengler, Tim Dass

Submitted: Mon, February 09 2015 by Lukas Borke
Submitted[Python]: Tue, April 16 2024 by Tim Dass

```

![Picture1](MVAcontnorm_1.png)

![Picture2](MVAcontnorm_python.png)

### R Code
```r


# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("MASS", "mnormt")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# parameter settings
n   = 200  # number of draws
mu  = c(3, 2)  # mean vector
sig = matrix(c(1, -1.5, -1.5, 4), ncol = 2)  # covariance matrix

# bivariate normal sample
set.seed(80)
y = mvrnorm(n, mu, sig, 2)

# bivariate normal density
xgrid = seq(from = (mu[1] - 3 * sqrt(sig[1, 1])), to = (mu[1] + 3 * sqrt(sig[1, 1])), 
    length.out = 200)
ygrid = seq(from = (mu[2] - 3 * sqrt(sig[2, 2])), to = (mu[2] + 3 * sqrt(sig[2, 2])), 
    length.out = 200)
z     = outer(xgrid, ygrid, FUN = function(xgrid, ygrid) {
    dmnorm(cbind(xgrid, ygrid), mean = mu, varcov = sig)
})

# Plot
par(mfrow = c(1, 2))
plot(y, col = "black", ylab = "X2", xlab = "X1", xlim = range(xgrid), ylim = range(ygrid))
title("Normal sample")

# Contour ellipses
contour(xgrid, ygrid, z, xlim = range(xgrid), ylim = range(ygrid), nlevels = 10, col = c("blue", 
    "black", "yellow", "cyan", "red", "magenta", "green", "blue", "black"), lwd = 3, 
    cex.axis = 1, xlab = "X1", ylab = "X2")
title("Contour Ellipses")

```

automatically created on 2024-04-25

### PYTHON Code
```python

# works on numpy 1.23.5, scipy 1.10.0 and matplotlib 3.6.2
import matplotlib.pyplot as plt
import numpy as np
from scipy.stats import multivariate_normal

np.random.seed(1)
n = 200  # number of draws
mu = np.array([3, 2])  # mean vector
sig = np.array([[1, -1.5], [-1.5, 4]])  # covariance matrix

y = np.random.multivariate_normal(mu, sig, n)

xgrid = np.linspace(mu[0] - 3 * np.sqrt(sig[0, 0]), mu[0] + 3 * np.sqrt(sig[0, 0]), 200)
ygrid = np.linspace(mu[1] - 3 * np.sqrt(sig[1, 1]), mu[1] + 3 * np.sqrt(sig[1, 1]), 200)
X, Y = np.meshgrid(xgrid, ygrid)
pos = np.dstack((X, Y))
rv = multivariate_normal(mu, sig)
z = rv.pdf(pos)

fig, axs = plt.subplots(ncols=2, figsize= (15,10))
axs[0].scatter(y[:, 0], y[:, 1], c='black')
axs[0].set_xlabel('X1', fontsize = 18)
axs[0].set_ylabel('X2', fontsize = 18)
axs[0].set_xlim([np.min(xgrid), np.max(xgrid)])
axs[0].set_ylim([np.min(ygrid), np.max(ygrid)])
axs[0].set_title('Normal sample', fontsize = 22)

axs[1].contour(xgrid, ygrid, z, levels=10, colors=('blue', 'black', 'yellow', 'cyan', 'red', 'magenta', 'green', 'blue', 'black'), linewidths=3)
axs[1].set_xlabel('X1', fontsize = 18)
axs[1].set_ylabel('X2', fontsize = 18)
axs[1].set_xlim([np.min(xgrid), np.max(xgrid)])
axs[1].set_ylim([np.min(ygrid), np.max(ygrid)])
axs[1].set_title('Contour Ellipses', fontsize = 22)

plt.show()

```

automatically created on 2024-04-25