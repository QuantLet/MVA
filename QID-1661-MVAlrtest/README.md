
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAlrtest** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVAlrtest

Published in : Applied Multivariate Statistical Analysis

Description : 'Calculates a regression (LSE) of price of blue pullovers X2, advertisement cost X3
and sales assistants X4 on sales X1 for a unrestricted and a restricted model and runs a LR and
F-test for the classic pullovers data.'

Keywords : 'MLE, linear regression, regression, linear, financial, hypothesis-testing, test,
F-test, F-statistic, sas'

Author : Awdesch Melzer

Author[SAS] : Svetlana Bykovskaya

Submitted : Wed, March 14 2012 by Dedy Dwi Prastyo

Submitted[SAS] : Wen, April 6 2016 by Svetlana Bykovskaya

Datafile : pullover.dat

```


### R Code:
```r

# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# load data
x   = read.table("pullover.dat")  

y   = x[, 1]                                                 # first column (sales)
n   = length(y)                                              # number of observations
x   = cbind(rep(1, length(x[, 1])), x[, 2], x[, 3], x[, 4])  # ones, second to fourth column
p   = dim(x)[2]                                              # number of parameters in beta
(b  = solve(t(x) %*% x) %*% t(x) %*% y)                      # MLE (LSE)

aa  = c(0, 1, 0.5, 0)                                        # matrix A
a   = 0                                                      # constant a
q   = length(a)                                              # number of parameters in constr. beta
(bc = b - solve(t(x) %*% x) %*% aa %*% solve(t(aa) %*% solve(t(x) %*% x) %*% aa) %*% 
    (t(aa) %*% b - a))                                       # constrained MLE

lrt1 = t(y - x %*% bc) %*% (y - x %*% bc)
lrt2 = t(y - x %*% b) %*% (y - x %*% b)
(lrt = n * log(lrt1/lrt2))                                  # LR test statistic

pchisq(lrt, q)                                              # prob to reject hypothesis        

ft1  = (aa %*% b - a) %*% solve(t(aa) %*% solve(t(x) %*% x) %*% aa) %*% t(aa %*% b - 
    a)
ft2  = lrt2
(ft   = ((n - p)/q) * ft1/ft2)                              # F test statistic                    
pf(ft, q, n - p)                                            # prob to reject hypothesis                          

```

### SAS Code:
```sas

* Import the data;
data pull;
  infile '/folders/myfolders/Sas-work/data/pullover.dat';
  input x1-x4; 
run;

proc iml;
  use pull;
    read all var _ALL_ into x;
  close pull;
  
  y = x[, 1];                                               * first column (sales);
  n = nrow(y);                                              * number of observations;
  x = repeat(1, nrow(x),1) || x[, 2] || x[, 3] || x[, 4];   * ones, second to fourth column;
  p = ncol(x);                                              * number of parameters in beta;
  b = inv(x` * x) * x` * y;                                 * MLE (LSE);
  print b[c ='MLE (LSE)'];
  
  aa  = {0, 1, 0.5, 0};                                     * matrix A;
  a   = 0;                                                  * constant a;
  q   = nrow(a);                                            * number of parameters in constr. beta;
  bc = b - inv(x` * x) * aa * inv(aa` * inv(x` * x) * aa) * (aa` * b - a); * constrained MLE;
  print bc[c ='constrained MLE'];
  
  lrt1 = t(y - x * bc) * (y - x * bc);
  lrt2 = t(y - x * b) * (y - x * b);
  lrt = n * log(lrt1/lrt2);                                 * LR test statistic;
  print lrt[c ='LR test statistic'];
  
  p2 = cdf("CHISQUARE", lrt, q);
  print p2[c ='prob to reject hypothesis'],aa,b;
  
  ft1  = (aa` * b - a) * inv(aa` * inv(x` * x) * aa) * (aa` * b - a)`;
  ft2  = lrt2;
  ft   = ((n - p)/q) * ft1/ft2;                             * F test statistic; 
  print ft[c ='F test statistic'];                   
  
  pf = cdf("F", ft, q, n);                                  * prob to reject hypothesis;
  print pf[c ='prob to reject hypothesis'];                          

quit;

```
