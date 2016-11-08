
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAcontbank3** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVAcontbank3

Published in : Applied Multivariate Statistical Analysis

Description : 'Gives a contour plot of the kernel density estimate of variables X4, X5 and X6 of
the Swiss bank notes.'

Keywords : '3D, data visualization, plot, graphical representation, financial, density,
descriptive, descriptive-statistics, empirical, gaussian, kde, kernel, smoothing, univariate,
visualization'

See also : 'MVAboxbank6, MVAdenbank2, MVAdenbank3, MVAdraftbank4, MVAscabank45, MVAscabank56,
MVAscabank456, SPMdenepatri, SPMkdeconstruct, SPMkernel'

Author : Song Song

Submitted : Tue, September 09 2014 by Awdesch Melzer

Datafiles : bank2.dat

```

![Picture1](MVAcontbank3_1.png)


### R Code:
```r

# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("KernSmooth", "misc3d")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
xx = read.table("bank2.dat")

d  = kde3d(xx[, 4], xx[, 5], xx[, 6], n = 15)

# plot
contour3d(d$d, level = c(max(d$d[10, 10, ]) * 0.02, max(d$d[10, 10, ]) * 0.5, max(d$d[10, 
    10, ]) * 1.3), fill = c(FALSE, FALSE, TRUE), col.mesh = c("green", "red", "blue"), 
    engine = "standard", screen = list(z = 210, x = -40, y = -295), scale = TRUE)
title("Swiss bank notes")

```
