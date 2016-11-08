
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAcareffect** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVAcareffect

Published in : Applied Multivariate Statistical Analysis

Description : 'Computes the effect of weight and the displacement on the mileage. Uses linear
regression to extract the coefficients of the regressors. Additionally, the program checks whether
the origin of the car has an effect on the response while considering different levels.'

Keywords : regression, multivariate, linear, linear-regression, linear-model

Author : Mengmeng Guo

Submitted : Tue, February 07 2012 by Dedy Dwi Prastyo

Datafile : carc.dat

```


### R Code:
```r

# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# Extract factors and build simple regression model for testing the W and D on effect of M
data  = read.table("carc.dat")
y     = data[, 2]
x1    = data[, 8]
x2    = data[, 11]
x     = cbind(x1, x2)
fit1  = lm(y ~ x)
summary(fit1)

# Adding the origin factor into the regression model to check the effect
x3    = data[, 13]
xx    = cbind(x, x3)
fit2  = lm(y ~ xx)
summary(fit2)

# Checking whether different levels have different effects on the mileage
xxx   = data[order(data[, 13]), ]

# Level: c = 1
y1    = xxx[1:52, ]
fit3  = lm(y1[, 2] ~ y1[, 8] + y1[, 11])
summary(fit3)

# Level: c = 2
y2    = xxx[53:63, ]
fit4  = lm(y2[, 2] ~ y2[, 8] + y2[, 11])
summary(fit4)

# Level: c = 3
y3    = xxx[63:74, ]
fit5  = lm(y3[, 2] ~ y3[, 8] + y3[, 11])
summary(fit5)

```
