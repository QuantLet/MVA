[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAparcoo2** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of Quantlet: MVAparcoo2

Published in: Applied Multivariate Statistical Analysis

Description: Computes a parallel coordinate plot for the observations of the full bank note data set.

Keywords: data visualization, graphical representation, plot, parallel-coordinates-plot, scaling, financial

See also: MVAandcur, MVAandcur2, MVAparcoo1, MVApcp1, MVApcp2, MVApcp3, MVApcp4, MVApcp5, MVApcp7, MVApcphousing

Author: Vladimir Georgescu, Jorge Patron, Song Song, Julia Wandke

Author[Python]: 'Matthias Fengler, Liudmila Gorkun-Voevoda'

Submitted: Tue, September 09 2014 by Awdesch Melzer

Submitted[Python]: 'Wed, April 22 2020 by Liudmila Gorkun-Voevoda'

Datafile: bank2.dat

```

![Picture1](MVAparcoo2_1.png)

![Picture2](MVAparcoo2_1_python.png)

### PYTHON Code
```python

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

data = pd.read_csv("bank2.dat", sep = "\s+", header=None)

c = np.ravel([[1]*100, [2]*100])

y = (data - data.min())/(data.max() - data.min())
y.loc[:, 6] = c
y.columns = ["1", "2", "3", "4", "5", "6", "c"]



fig, ax = plt.subplots(figsize = (15, 10))
pd.plotting.parallel_coordinates(y, "c", color = ["black", "r"])
ax.legend().set_visible(False)
plt.title("Parallel coordinates plot (Bank data)")

plt.show()


```

automatically created on 2020-04-22

### R Code
```r


# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("MASS")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)


# load data
data = read.table("bank2.dat")
C    = c(rep(1, 100), rep(2, 100))
x    = data

# plot
ir   = rbind(x[, , 1], x[, , 2], x[, , 3], x[, , 4], x[, , 5], x[, , 6])
parcoord(log(ir)[, c(1, 2, 3, 4, 5, 6)], lty = c(rep(1, 5), rep(4, 5)), lwd = 2, col = C, main = "Parallel coordinates plot (Bank data)", 
    frame = TRUE)
axis(side = 2, at = seq(0, 1, 0.2), labels = seq(0, 1, 0.2))

```

automatically created on 2020-04-22