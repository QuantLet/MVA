
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAghsurface** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVAghsurface

Published in : Applied Multivariate Statistical Analysis

Description : Generates a 3D surface plot of the Gumbel-Hougaard copula for theta = 3.

Keywords : 3D, plot, graphical representation, surface, gumbel, copula

See also : MVAgumbelclayton

Author : Song Song, Matthias Eckardt

Submitted : Sun, January 29 2012 by Dedy Dwi Prastyo

```

![Picture1](MVAghsurface.png)


### R Code:
```r

# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("grid", "lattice")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# reproduction of matrix of coordinates Creating a function for reproduction of
# coordinates
f = function(u, v, theta) {
    exp(-((-log(u))^theta + (-log(v))^theta)^(1/theta))
}

N     = 21
v     = (u <- seq(0, 1, by = 0.05))
uu    = rep(u, N)
vv    = rep(v, each = N)
theta = 3
w     = matrix(f(uu, vv, theta), nr = N)

persp(w, lwd = 3, cex.axis = 2, cex.lab = 2, scale = T) 
title(paste("3D surface plot "))

```
