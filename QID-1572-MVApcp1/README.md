
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVApcp1** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVApcp1

Published in : Applied Multivariate Statistical Analysis

Description : Computes parallel coordinates plot for car data.

Keywords : 'pcp, parallel-coordinates-plot, financial, data visualization, plot, graphical
representation'

See also : MVApcphousing, MVApcp2, MVApcp3, MVApcp4, MVApcp5, MVApcp6, MVApcp7, MVApcp8

Author : Ji Cao, Song Song, Vladimir Georgescu, Awdesch Melzer

Submitted : Tue, September 09 2014 by Awdesch Melzer

Datafile : carc.txt

```

![Picture1](MVApcp1.png)


### R Code:
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
x = read.table("carc.txt")

d = x[, 13]
s = x[, 13]
d[c(x[, 13] == 1)] = 3
d[c(x[, 13] == 2)] = 1
d[c(x[, 13] == 3)] = 2
s[c(x[, 13] == 1)] = 2
s[c(x[, 13] == 2)] = 1
s[c(x[, 13] == 3)] = 4

# Plot
ir = rbind(x[, , 1], x[, , 2], x[, , 3], x[, , 4], x[, , 5], x[, , 6], x[, , 7], 
    x[, , 8], x[, , 9], x[, , 10], x[, , 11], x[, , 12], x[, , 13])
parcoord(log(ir)[, seq(1, 13, 1)], lty = d, lwd = 1, col = s, main = "Parallel Coordinates Plot (Car Data)", 
    frame = TRUE)
axis(side = 2, at = seq(0, 1, 0.2), labels = seq(0, 1, 0.2))
legend("bottom", c("us", "japan", "europe"), col = c(2, 1, 4), lty = c(3, 1, 2), 
    horiz = TRUE, cex = 0.6) 


```
