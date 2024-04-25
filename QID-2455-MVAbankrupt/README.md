[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="1100" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAbankrupt** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet: MVAbankrupt

Published in: Applied Multivariate Statistical Analysis

Description: Computes the effects of financial characteristics on bankrupt with logit model.

Keywords: logit, regression, probability, characteristic, financial

See also: MSElogit, MSEglmest, MSElorenz

Author: Mengmeng Guo
Author[Python]: Matthias Fengler, Tim Dass

Submitted: Thu, June 05 2014 by Sergey Nasekin
Submitted[Python]: Tue, April 23 2024 by Tim Dass

Datafile: bankrupt.txt

Example: The coefficients of the five characteristics of bankrupt data for logit model, backfitting method and three independent variables.

Code warning: 'glm.fit: fitted probabilities numerically 0 or 1 occurred' 

```

### PYTHON Code
```python

#works on pandas 1.5.3 and statsmodels 0.14.0
import pandas as pd
import statsmodels.api as sm

data = pd.read_table("bankrupt.txt", sep="\s+", header=None, names = [1,2,3,4,5,6]) 
y = data.loc[:, 6]
X = sm.add_constant(data.loc[:,[3,4,5]])
fit = sm.Logit(y, X).fit()

print(fit.summary())
```

automatically created on 2024-04-25

### R Code
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

automatically created on 2024-04-25