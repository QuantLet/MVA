
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAcorrCar** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVAcorrCar

Published in : Applied Multivariate Statistical Analysis

Description : Computes the Chi-Square test statistics for the car data.

Keywords : correspondence-analysis, independence, test, chi-square-test, chi-square, financial, sas

See also : 'MVAcorrbac, MVAcorrEyeHair, MVAcorrcrime, MVAcorrjourn, SMScorrcrime, SMScorrcarm,
SMScorrfood, SMScorrhealth'

Author : Andrija Mihoci, Xiaofeng Cao

Author[SAS] : Svetlana Bykovskaya

Submitted : Mon, October 17 2011 by Awdesch Melzer

Submitted[SAS] : Wen, April 6 2016 by Svetlana Bykovskaya

```


### R Code:
```r

# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# Data (X3 vs. X4, r = number of rows, c = number of columns)
r     = 5
c     = 5
X3x4  = c(1, 1, 0, 0, 0, 0, 7, 1, 0, 0, 2, 2, 19, 5, 0, 0, 0, 6, 11, 0, 0, 1, 1, 4, 
    5)
X3x4  = matrix(X3x4, nrow = r, ncol = c)
X3x4  = t(X3x4)            # Data matrix
rowst = rowSums(X3x4)      # marginal row
colst = colSums(X3x4)      # marginal column
n     = sum(X3x4)          # sample size

# Expected values under independence (X3 vs. X4)
E     = matrix(rep(NA, r * c), nrow = r, ncol = c)
for (i in c(0:(r - 1))) {
    i = i + 1
    for (j in c(0:(c - 1))) {
        j = j + 1
        e = rowst[i] * colst[j]/n
        E[i, j] = e
    }
}

# Chi-Square test statistic (X3 vs. X4)
(Chi2_X3X4 = sum(sum((E - X3x4)^2/E)))

# Data (X3 vs. X13, r = number of rows, c = number of columns)
r     = 5
c     = 3
X3X13 = c(2, 0, 0, 8, 0, 0, 26, 0, 2, 8, 5, 4, 2, 6, 3)
X3X13 = matrix(X3X13, nrow = c, ncol = r)
X3X13 = t(X3X13)           # Data matrix
rowst = rowSums(X3X13)     # marginal row
colst = colSums(X3X13)     # marginal column
n     = sum(X3X13)         # sample size

# Expected values under independence (X3 vs. X13)
E     = matrix(rep(NA, r * c), nrow = r, ncol = c)
for (i in c(0:(r - 1))) {
    i = i + 1
    for (j in c(0:(c - 1))) {
        j = j + 1
        e = rowst[i] * colst[j]/n
        E[i, j] = e
    }
}

# Chi-Square test statistic (X3 vs. X13)
(Chi2_X3X13 = sum(sum((E - X3X13)^2/E)))

# Data (X4 vs. X13, r = number of rows, c = number of columns)
r     = 5
c     = 3
X4X13 = c(2, 0, 1, 10, 0, 1, 21, 1, 5, 13, 5, 2, 0, 5, 0)
X4X13 = matrix(X4X13, nrow = c, ncol = r)
X4X13 = t(X4X13)           # Data matrix
rowst = rowSums(X4X13)     # marginal row
colst = colSums(X4X13)     # marginal column
n     = sum(X4X13)         # sample size

# Expected values under independence (X4 vs. X13)
E     = matrix(rep(NA, r * c), nrow = r, ncol = c)
for (i in c(0:(r - 1))) {
    i = i + 1
    for (j in c(0:(c - 1))) {
        j = j + 1
        e = rowst[i] * colst[j]/n
        E[i, j] = e
    }
}

# Chi-Square test statistic (X4 vs. X13)
(Chi2_X4X13 = sum(sum((E - X4X13)^2/E)))

# Chi-Square test statistics
(Chi2       = c(Chi2_X3X4, Chi2_X3X13, Chi2_X4X13))

```

### SAS Code:
```sas
proc iml;
  start ChiSq(r, c, x);
    x = shape(x, r, c);
    rowst = x[,+];
    colst = x[+,];
    n = x[+,+];
    
    * Expected values under independence;
    E = j(r, c, 0);
    do i = 0 to r-1;
      do j = 0 to c-1;
        E[i + 1,j + 1] = rowst[i + 1] * colst[j + 1] / n;
      end;
    end;
    
    Chi = ((E - x) ## 2 / E)[+,+];
    return(Chi);
  finish;
  
  * Data (X3 vs. X4, r = number of rows, c = number of columns);
  r = 5;
  c = 5;
  X3X4 = {1, 1, 0, 0, 0, 0, 7, 1, 0, 0, 2, 2, 19, 5, 0, 0, 0, 6, 11, 0, 0, 1, 1, 4, 5};
  Chi2_X3X4 = ChiSq(r, c, X3X4); * * Chi-Square test statistic (X3 vs. X4);
  
  * Data (X3 vs. X13, r = number of rows, c = number of columns);
  r = 5;
  c = 3;
  X3X13 = {2, 0, 0, 8, 0, 0, 26, 0, 2, 8, 5, 4, 2, 6, 3};
  Chi2_X3X13 = ChiSq(r, c, X3X13); * Chi-Square test statistic (X3 vs. X13);
  
  * Data (X4 vs. X13, r = number of rows, c = number of columns);
  r = 5;
  c = 3;
  X4X13 = {2, 0, 1, 10, 0, 1, 21, 1, 5, 13, 5, 2, 0, 5, 0};
  Chi2_X4X13 = ChiSq(r, c, X4X13); * Chi-Square test statistic (X4 vs. X13);
  
  * Chi-Square test statistics;
  Chi2 = Chi2_X3X4 || Chi2_X3X13 || Chi2_X4X13;
  print Chi2;
quit;


```
