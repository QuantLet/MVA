[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="1100" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAbluepullover** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of Quantlet: MVAbluepullover

Published in: Applied Multivariate Statistical Analysis

Description: Rewrites the 5.3 example using the classic blue pullover example and show the mean, covariance and correlation matrix of data.

Keywords: correlation, correlation-matrix, covariance, covariance-matrix, mean, financial

See also: MVAdescbh, SFSmvol01, SFEVolaCov

Author: Matthias Eckardt
Author[Python]: Matthias Fengler, Tim Dass

Submitted: Mon, July 07 2014 by Lukas Borke
Submitted[Python]: Tue, April 16 2024 by Tim Dass

Datafile: pullover.dat

```

### PYTHON Code
```python

# works on pandas 1.5.3 and numpy 1.24.3
import pandas as pd
import numpy as np

blue_data = pd.read_table("pullover.dat", header=None, delim_whitespace=True)
mu = np.mean(blue_data, axis=0)
mu = np.transpose(mu)
print("mu =", mu)
s_unbiased = np.cov(blue_data, rowvar=False, ddof=1) # unbiased estimate of covariance matrix
covxy = s_unbiased / (10/9) # calculating covariance using the formula n/n-1*S
print("cov_xy =", covxy)

xdata = blue_data.iloc[:, :2]
zdata = blue_data.iloc[:, 2:]
Sxx = np.cov(xdata, rowvar=False)
Sxz = np.cov(xdata, zdata, rowvar=False)[0:2,2:4]
Szz = np.cov(zdata, rowvar=False)
Sxx_z = Sxx - np.dot(Sxz, np.dot(np.linalg.inv(Szz), Sxz.T))
rxx_z = Sxx_z[0, 1]/np.sqrt(Sxx_z[0, 0]*Sxx_z[1, 1]) # calculating correlation using formula r = cov/(std_dev1 * std_dev2)
print("rxx_z =", np.round(rxx_z, 3))

# correlation matrix
P_blue_data = np.corrcoef(blue_data, rowvar=False)
print("P_blue_data =\n",  np.round(P_blue_data, 3))

```

automatically created on 2024-04-25

### R Code
```r


# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

#load data
blue.data = read.table("pullover.dat", header = T)
attach(blue.data)

# generating mu and S
mu  = colMeans(blue.data)
mu  = t(mu)
(mu = t(mu))
s.unbiased = cov(blue.data)  # the result of cov(xy) is the unbiased one
 
# meaning n/n-1*S
(covxy = s.unbiased/(10/9))

# partial correlation between 'Sales' and 'Price' given 'Advertisement' and 'Sales Assistans', x1 = Sales, x2 = Price
z      = blue.data[c(3:4)]
data   = data.frame(blue.data[, 1], blue.data[, 2], z)
xdata  = na.omit(data.frame(data[, c(1, 2)]))
Sxx    = cov(xdata, xdata)
xzdata = na.omit(data)
xdata  = data.frame(xzdata[, c(1, 2)])
zdata  = data.frame(xzdata[, -c(1, 2)])
Sxz    = cov(xdata, zdata)
zdata  = na.omit(data.frame(data[, -c(1, 2)]))
Szz    = cov(zdata, zdata)
Sxx.z  = Sxx - Sxz %*% solve(Szz) %*% t(Sxz)
(rxx.z = cov2cor(Sxx.z)[1, 2])

# correlation matrix
(P.blue.data = cor(blue.data))

```

automatically created on 2024-04-25