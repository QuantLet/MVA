
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAcorrEyeHair** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVAcorrEyeHair

Published in : Applied Multivariate Statistical Analysis

Description : Computes the Chi-Square test statistic for the Eye-Hair data.

Keywords : correspondence-analysis, independence, test, chi-square-test, chi-square, sas

See also : 'MVAcorrbac, MVAcorrcrime, MVAcorrjourn, MVAcorrCar, SMScorrcrime, SMScorrcarm,
SMScorrfood, SMScorrhealth'

Author : Andrija Mihoci, Xiaofeng Cao

Author[SAS] : Svetlana Bykovskaya

Submitted : Wed, September 07 2011 by Awdesch Melzer

Submitted[SAS] : Wen, April 6 2016 by Svetlana Bykovskaya

```


### R Code:
```r

# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# Data (eye color vs. hair color, r = number of rows, c = number of columns)
r     = 4
c     = 4
X     = c(68, 119, 26, 7, 15, 54, 14, 10, 5, 29, 14, 16, 20, 84, 17, 94)
X     = matrix(X, nrow = r, ncol = c)
X     = t(X)             # Data matrix
rowst = rowSums(X)       # marginal row
colst = colSums(X)       # marginal column
n     = sum(X)           # sample size

# Expected values under independence
E     = matrix(rep(NA, r * c), nrow = r, ncol = c)
for (i in c(0:(r - 1))) {
    i = i + 1
    for (j in c(0:(c - 1))) {
        j = j + 1
        e = rowst[i] * colst[j]/n
        E[i, j] = e
    }
}
E

# Chi-Square test statistic
(Chi2  = sum(sum((E - X)^2/E)))

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
  
  * Data (eye color vs. hair color, r = number of rows, c = number of columns);
  r = 4;
  c = 4;
  X = {68, 119, 26, 7, 15, 54, 14, 10, 5, 29, 14, 16, 20, 84, 17, 94};
  
  * Chi-Square test statistic;
  Chi2 = ChiSq(r, c, X);
  print Chi2;
quit;
```
