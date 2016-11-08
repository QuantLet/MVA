
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAbankrupt** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVAbankrupt

Published in : Applied Multivariate Statistical Analysis

Description : Computes the effects of financial characteristics on bankrupt with logit model.

Keywords : logit, regression, probability, characteristic, financial

See also : MSElogit, MSEglmest, MSElorenz

Author : Mengmeng Guo

Submitted : Thu, June 05 2014 by Sergey Nasekin

Datafile : bankrupt.txt

Example : 'The coefficients of the five characteristics of bankrupt data for logit model,
backfitting method and three independent variables.'

Code warning : 'glm.fit: fitted probabilities numerically 0 or 1 occurred'

```


### R Code:
```r

# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# read data and set variables
data  = read.table("bankrupt.txt")
length(data)
y     = data[, 6]
x1    = data[, 1]
x2    = data[, 2]
x3    = data[, 3]
x4    = data[, 4]
x5    = data[, 5]

# compute logit model
fit   = glm(y ~ x3 + x4 + x5, family = binomial(link = "logit"))
summary(fit)

```
