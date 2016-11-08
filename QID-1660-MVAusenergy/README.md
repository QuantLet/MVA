
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAusenergy** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVAusenergy

Published in : Applied Multivariate Statistical Analysis

Description : 'Computes a test statistic for the variance of the US energy company data. H0:
empirical variance is equal to the theoretical variance, given unknown mean.'

Keywords : 'multivariate, variance, mean, test, statistics, MLE, hypothesis-testing,
likelihood-ratio-test, sas'

Author : Wolfgang K. Haerdle

Author[SAS] : Svetlana Bykovskaya

Submitted : Wed, March 14 2012 by Dedy Dwi Prastyo

Submitted[SAS] : Wen, April 6 2016 by Svetlana Bykovskaya

```


### R Code:
```r

# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# energy sector data
x = rbind(c(13621, 4848, 4572, 485, 898.9, 23.4), c(1117, 1038, 478, 59.7, 91.7, 
    3.8), c(1633, 701, 679, 74.3, 135.9, 2.8), c(5651, 1254, 2002, 310.7, 407.9, 
    6.2), c(5835, 4053, 1601, -93.8, 173.8, 10.8), c(3494, 1653, 1442, 160.9, 320.3, 
    6.4), c(1654, 451, 779, 84.8, 130.4, 1.6), c(1679, 1354, 687, 93.8, 154.6, 4.6), 
    c(1257, 355, 181, 167.5, 304, 0.6), c(1743, 597, 717, 121.6, 172.4, 3.5), c(1440, 
        1617, 639, 81.7, 126.4, 3.5), c(14045, 15636, 2754, 418, 1462, 27.3), c(3010, 
        749, 1120, 146.3, 209.2, 3.4), c(3086, 1739, 1507, 202.7, 335.2, 4.9), c(1995, 
        2662, 341, 34.7, 100.7, 2.3))

cov(x[, 1:2])                   # unbiased variance matrix for energy sector
(s = cov(x[, 1:2]) * 14/15)     # MLE/empirical variance matrix for energy sector 

# manufacturing sector data
y = rbind(c(1093, 1679, 1070, 100.9, 164.5, 20.8), c(1128, 1516, 430, -47, 26.7, 
    13.2), c(1804, 2564, 483, 70.5, 164.9, 26.6), c(4662, 4781, 2988, 28.7, 371.5, 
    66.2), c(6307, 8199, 598, -771.5, -524.3, 57.5), c(2366, 3305, 1117, 131.2, 256.5, 
    25.2), c(4084, 4346, 3023, 302.7, 521.7, 37.5), c(10348, 5721, 1915, 223.6, 322.5, 
    49.5), c(752, 2149, 101, 11.1, 15.2, 2.6), c(10528, 14992, 5377, 312.7, 710.7, 
    184.8))

cov(y[, 1:2])                   # unbiased variance matrix for manufacturing sector 
(sigma = cov(y[, 1:2]) * 9/10)  # empirical/MLE variance matrix for manufacturing sector

# testing statistic
(test = 15 * sum(diag(solve(sigma) %*% s)) - 15 * log10(det(solve(sigma) %*% s)) - 
    15 * 2)

# P-value
(p = 1 - pchisq(test, 3)) 

```

### SAS Code:
```sas

* energy sector data;
data energy;                      
  input t1-t6;       
  datalines;             
    13621  4848 4572 485.0  898.9 23.4
    1117  1038  478  59.7   91.7  3.8
    1633   701  679  74.3  135.9  2.8
    5651  1254 2002 310.7  407.9  6.2
    5835  4053 1601 -93.8  173.8 10.8
    3494  1653 1442 160.9  320.3  6.4
    1654   451  779  84.8  130.4  1.6
    1679  1354  687  93.8  154.6  4.6
    1257   355  181 167.5  304.0  0.6
    1743   597  717 121.6  172.4  3.5
    1440  1617  639  81.7  126.4  3.5
    14045 15636 2754 418.0 1462.0 27.3
    3010   749 1120 146.3  209.2  3.4
    3086  1739 1507 202.7  335.2  4.9
   1995  2662  341  34.7  100.7  2.3
  ;                              

* manufacturing sector data;
data sector;                      
  input t1-t6;       
  datalines;             
    1093  1679 1070  100.9  164.5  20.8
    1128  1516  430  -47.0   26.7  13.2
    1804  2564  483   70.5  164.9  26.6
    4662  4781 2988   28.7  371.5  66.2
    6307  8199  598 -771.5 -524.3  57.5
    2366  3305 1117  131.2  256.5  25.2
    4084  4346 3023  302.7  521.7  37.5
    10348  5721 1915  223.6  322.5  49.5
    752  2149  101   11.1   15.2   2.6
    10528 14992 5377  312.7  710.7 184.8
  ;                              

* unbiased variance matrix for energy sector;
proc corr data = energy noprob outp = OutCorr1 nomiss cov noprint; 
  var t1 t2;
run;

* unbiased variance matrix for manufacturing sector;
proc corr data = sector noprob outp = OutCorr2 nomiss cov noprint; 
  var t1 t2;
run;

proc iml;
  use OutCorr1 where(_TYPE_="COV");
    read all var _NUM_ into cov1[colname=varNames];
  close OutCorr1;
  
  use OutCorr2 where(_TYPE_="COV");
    read all var _NUM_ into cov2[colname=varNames];
  close OutCorr2;
  
  cov1 = cov1 * 14/15;
  print 'MLE/empirical variance matrix for energy sector', cov1;
  
  cov2 = cov2 * 9/10;
  print 'MLE/empirical variance matrix for manufacturing sector', cov2;
  
  test = 15 * sum(diag(inv(cov2) * cov1))- 15 * log10(det(inv(cov2) * cov1)) - 
    15 * 2 ;
  print test[c ='testing statistic'];
  
  p = 1 - cdf("CHISQUARE", test, 3);
  print p[c ='P-value'];
quit;






```
