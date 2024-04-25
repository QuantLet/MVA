[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="1100" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAdescbh** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet: MVAdescbh

Published in: Applied Multivariate Statistical Analysis

Description: 'Calculates descriptive statistics for the Boston housing data and their transformations.'

Keywords: correlation, correlation-matrix, covariance, covariance-matrix, descriptive, descriptive-statistics, five number summary, mean, statistics, transformation, sas

See also: MVAlinregbh, MVAlinreg2bh, MVAsimcibh, MVAdiscbh, MVAclusbh, MVAboxbhd, MVAaerbh

Author: Vladimir Georgescu, Jorge Patron, Song Song, Awdesch Melzer
Author[SAS]: Svetlana Bykovskaya
Author[Python]: Matthias Fengler, Tim Dass

Submitted: Mon, September 15 2014 by Awdesch Melzer
Submitted[SAS]: Wen, April 6 2016 by Svetlana Bykovskaya
Submitted[Python]: Tue, April 16 2024 by Tim Dass

Datafiles: bostonh.dat
```

### R Code
```r


# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# load data
x = read.table("bostonh.dat")
xt = x

# Transformation
xt[, 1] = log(x[, 1])
xt[, 2] = x[, 2]/10
xt[, 3] = log(x[, 3])
xt[, 5] = log(x[, 5])
xt[, 6] = log(x[, 6])
xt[, 7] = ((x[, 7]^2.5))/10000
xt[, 8] = log(x[, 8])
xt[, 9] = log(x[, 9])
xt[, 10] = log(x[, 10])
xt[, 11] = exp(0.4 * x[, 11])/1000
xt[, 12] = x[, 12]/100
xt[, 13] = sqrt(x[, 13])
xt[, 14] = log(x[, 14])

tablex = rbind(t(apply(x, 2, mean)), t(apply(x, 2, median)), t((apply(x, 2, sd))^2), 
    t(apply(x, 2, sd)))
print("Table with Mean, Median, Variance, Sqrt(Variance) for Original Data")
print("  Mean   Median  Variance   SE")
t(round(tablex, 4))

print("Covariance Matrix Original Data")
print(cov(x))

print("Correlation Matrix Original Data")
print(cor(x))

tablext = cbind(apply(xt, 2, mean), apply(xt, 2, median), (apply(xt, 2, sd))^2, 
    apply(xt, 2, sd))

print("Table with Mean, Median, Variance, Sqrt(Variance) for Transformed Data")
print("     Mean     Median    Variance    SE")
round(tablext, 4)
print("Covariance Matrix Transformed Data")
print(cov(xt))
print("Correlation Matrix Transformed Data")
print(cor(xt))


```

automatically created on 2024-04-25

### PYTHON Code
```python

#works on pandas 1.5.2 and numpy 1.23.5
import pandas as pd
import numpy as np

df = pd.read_csv('bostonh.dat', sep='\s+', header=None, names=np.arange(1,15,1))

df2 = pd.DataFrame()
df2[[1,3,5,6,8,9,10,14]] = np.log(df[[1,3,5,6,8,9,10,14]])
df2[4] = df[4]
df2.loc[:,2] = df.loc[:,2]/10
df2.loc[:,7] = (pow(df.loc[:,7],2.5))/10000
df2.loc[:,11] = (np.exp(0.4*df.loc[:,11]))/1000
df2.loc[:,12] = df.loc[:,12]/100
df2.loc[:,13] = pow(df.loc[:,13],0.5)

cols= np.arange(1,15,1)
df2 = df2[cols]

original_data_summary = pd.DataFrame({
    'Mean': df.mean(),
    'Median': df.median(),
    'Variance': df.var(),
    'Standard Deviation': df.std()
})
print(original_data_summary)

transformed_data_summary = pd.DataFrame({
    'Mean': df2.mean(),
    'Median': df2.median(),
    'Variance': df2.var(),
    'Standard Deviation': df2.std()
})
print(transformed_data_summary)


```

automatically created on 2024-04-25

### SAS Code
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
  
  z = xt[, 1:3] || xt[,5:14]; 
  create dat from datax[colname={"t1" "t2" "t3" "t4" "t5" "t6" "t7" "t8" "t9" "t10" "t11" "t12" "t13"}];
    append from datax;
  close dat; 
  
  create dat2 from z[colname={"t1" "t2" "t3" "t4" "t5" "t6" "t7" "t8" "t9" "t10" "t11" "t12" "t13"}];
    append from z;
  close dat2;  
quit;

* descriptive statistics for original data;
title 'Descriptive statistics for original data';
proc means data = dat mean median var std;
run;

proc corr data = dat noprob cov pearson;
  ods select cov PearsonCorr;
run;

* descriptive statistics for transformed data;
title 'Descriptive statistics for transformed data';
proc means data = dat2 mean median var std;
run;

proc corr data = dat2 noprob cov pearson;
  ods select cov PearsonCorr;
run;

   
```

automatically created on 2024-04-25