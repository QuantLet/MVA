
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAlinregbh** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVAlinregbh

Published in : Applied Multivariate Statistical Analysis

Description : Builds a linear regression model for the complete transformed Boston housing data.

Keywords : linear, regression, linear-regression, financial, estimation, sas

See also : 'MVAlinreg2bh, MMSTATlinreg, MVAregbank, MVAregpull, MVAregzoom, MVAsimcibh, MVAdiscbh,
MVAdescbh, MVAclusbh, MVAboxbhd, MVAaerbh'

Author : Till Grossmass, Jorge Patron, Vladimir Georgescu, Song Song, Awdesch Melzer

Author[SAS] : Svetlana Bykovskaya

Submitted : Wed, February 29 2012 by Dedy Dwi Prastyo

Submitted[SAS] : Wen, April 6 2016 by Svetlana Bykovskaya

Datafile : bostonh.dat

```


### R Code:
```r

# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# load data
x   = read.table("bostonh.dat")
xt  = x

# Transformations
xt[, 1]   = log(x[, 1])
xt[, 2]   = x[, 2]/10
xt[, 3]   = log(x[, 3])
xt[, 5]   = log(x[, 5])
xt[, 6]   = log(x[, 6])
xt[, 7]   = ((x[, 7]^2.5))/10000
xt[, 8]   = log(x[, 8])
xt[, 9]   = log(x[, 9])
xt[, 10]  = log(x[, 10])
xt[, 11]  = exp(0.4 * x[, 11])/1000
xt[, 12]  = x[, 12]/100
xt[, 13]  = sqrt(x[, 13])
xt[, 14]  = log(x[, 14])

Z = cbind(rep(1, length(xt[, 1])), xt[, 1], xt[, 2], xt[, 3], xt[, 4], xt[, 5], +xt[, 
    6], xt[, 7], xt[, 8], xt[, 9], xt[, 10], xt[, 11], xt[, 12], xt[, 13])

y       = xt[, 14]
mn      = dim(Z)
df      = mn[1] - mn[2]
b       = solve(t(Z) %*% Z) %*% t(Z) %*% y
yhat    = Z %*% b
r       = y - yhat
mse     = t(r) %*% r/df
covar   = solve(t(Z) %*% Z) %*% diag(rep(mse, 14))
se      = sqrt(diag(covar))
t       = b/se
t2      = abs(t)
k       = t2^2/(df + t2^2)
p       = 0.5 * (1 + sign(t2) * pbeta(k, 0.5, 0.5 * df))
Pvalues = 2 * (1 - p)

tablex = cbind(round(b, 4), round(se, 4), round(t, 3), round(Pvalues, 4))
print("Table with coefficient estimates, Standard error, value of the +\nt-statistic and p-value (for the intercept (first line) and the 13    +\nvariables (lines 2 to 14))")
tablex 

```

### SAS Code:
```sas
* Import the data;
data bostonh;
  infile '/folders/myfolders/Sas-work/data/bostonh.dat';
  input temp1-temp14;
run;

proc iml;
  * Read data into a matrix;
  use bostonh;
    read all var _ALL_ into datax; 
  close bostonh;
  
  xt = datax;
  xt[, 1]  = log(datax[, 1]);
  xt[, 2]  = datax[, 2]/10;
  xt[, 3]  = log(datax[, 3]);
  xt[, 5]  = log(datax[, 5]);
  xt[, 6]  = log(datax[, 6]);
  xt[, 7]  = (datax[, 7] ## (2.5))/10000;
  xt[, 8]  = log(datax[, 8]);
  xt[, 9]  = log(datax[, 9]);
  xt[, 10] = log(datax[, 10]);
  xt[, 11] = exp(0.4 * datax[, 11])/1000;
  xt[, 12] = datax[, 12]/100;
  xt[, 13] = sqrt(datax[, 13]);
  xt[, 14] = log(datax[, 14]);
  
  z = xt[, 14] || xt[,1:13];
  
  create dat from z[colname={"y" "t1" "t2" "t3" "t4" "t5" "t6" "t7" "t8" "t9" "t10" "t11" "t12" "t13"}];
    append from z;
  close dat;  
quit;

* regression;
ods graphics on;
proc reg data = dat
    plots(only) = (fit(nocli stats=none));
  model y = t1-t13;
run;
ods graphics off;
   
```
