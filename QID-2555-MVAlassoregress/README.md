
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAlassoregress** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVAlassoregress

Published in : Applied Multivariate Statistical Analysis

Description : 'Performs a standardized regression using the Lasso methodology. The estimates become
nonzero at a point that means the variables enter the model equation sequentially as the scaled
shrinkage parameter increases. The Lasso technique results in variable selection. Finally, the
resulting Lasso estimates are plotted.'

Keywords : 'estimation, lasso, lasso shrinkage, logit, regression, forecast, data visualization,
plot, graphical representation, financial'

See also : MVAlassocontour, MVAlassologit, SMSlassocar, SMSlassoridge, LCPvariance

Author : Sergey Nasekin, Dedy D. Prastyo

Submitted : Tue, September 16 2014 by Sergey Nasekin

Datafiles : carc.dat

Example : Plot of lasso estimates for different scaled parameter.

```

![Picture1](MVAlassoregress_1.png)


### R Code:
```r

# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("lars")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
data = read.table("carc.dat")

y   = data[, 2]
x1  = data[, 3]
x2  = data[, 4]
x3  = data[, 5]
x4  = data[, 6]
x5  = data[, 7]
x6  = data[, 8]
x7  = data[, 9]
x8  = data[, 10]
x9  = data[, 11]
x10 = data[, 12]
x11 = data[, 13]
x12 = data[, 14]

x   = cbind(x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12)
(lasso.regress = lars(x, y, type = "lasso", normalize = TRUE, intercept = TRUE, max.steps = 1000))
summary(lasso.regress)

# plot
plot.lars(lasso.regress, lwd = 3)

```
