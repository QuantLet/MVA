[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="1100" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAnpcatime** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet: MVAnpcatime

Published in: Applied Multivariate Statistical Analysis

Description: 'Performs a PCA for the standardized time 
budget data and shows the first two principal components 
for the individuals and the variables.'

Keywords: principal-components, pca, npca, eigenvalues, standardization, eigenvalue-decomposition, plot, graphical representation, data visualization, sas 

See also: MVAnpcabanki, MVAnpcahous, MVAnpcahousi, MVAnpcabank, MVAnpcafood, MVAnpcausco, MVAnpcausco2, MVAnpcausco2i, MVAcpcaiv, MVApcabank, MVApcabanki, MVApcabankr, MVApcasimu

Author: Zografia Anastasiadou, Awdesch Melzer
Author[SAS]: Svetlana Bykovskaya
Author[Python]: Matthias Fengler, Tim Dass

Submitted: Wed, April 02 2014 by Awdesch Melzer
Submitted[SAS]: Tue, April 5 2016 by Svetlana Bykovskaya
Submitted[Python]: Tue, April 23 2024 by Tim Dass

Datafile: timebudget.dat

Example: 
- 1: Representation of the individuals.
- 2: Representation of the variables.

```

![Picture1](MVAnpcatime-1.png)

![Picture2](MVAnpcatime-1_python.png)

![Picture3](MVAnpcatime-2.png)

![Picture4](MVAnpcatime-2_python.png)

![Picture5](MVAnpcatime_1-1.png)

![Picture6](MVAnpcatime_2-1.png)

### PYTHON Code
```python

#works on numpy 1.25.2, pandas 2.1.1 and matplotlib 3.8.0
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle

x = pd.read_csv('timebudget.dat', sep="\s+", header = None)

n, p = x.shape
x = (x-x.mean())/(np.sqrt((n-1) * np.var(x, axis=0)))
e, v = np.linalg.eig(np.dot(x, x.T/n))
w = v[:,0:2] * np.sqrt(e[0:2])

labels = ["maus", "waus", "wnus", "mmus", "wmus", "msus", "wsus", "mawe", "wawe", 
    "wnwe", "mmwe", "wmwe", "mswe", "wswe", "mayo", "wayo", "wnyo", "mmyo", "wmyo", 
    "msyo", "wsyo", "maes", "waes", "wnes", "mmes", "wmes", "mses", "wses"]

fig, ax = plt.subplots(figsize=(8, 6))
ax.plot([0,0],[-0.6,0.6], color='grey', alpha=0.5)
ax.plot([-1,0.6],[0,0], color='grey', alpha=0.5)
ax.set_xlim(-0.17, 0.12)
ax.set_ylim(-0.11, 0.1)
ax.scatter(w[:,0], w[:,1])
[ax.annotate(name, (w[i, 0], w[i, 1])) for i, name in enumerate(labels)]
ax.set_title('Time Budget Data')
ax.set_xlabel('First Factor - Individuals')
ax.set_ylabel('Second Factor - Individuals')
plt.show()

e1, v1 = np.linalg.eig(np.dot(x.T, x))
z = v1[:,0:2] * np.sqrt(e1[0:2])

labels = ["prof", "tran", "hous", "kids", "shop", "pers", "eati", "slee", "tele", 
    "leis"]

fig, ax = plt.subplots(figsize=(8, 8))
ax.plot([0,0],[-1,1], color='grey', alpha=0.5)
ax.plot([-1,1],[0,0], color='grey', alpha=0.5)
ax.set_ylim(-1,1)
ax.set_xlim(-1,1)
circle = Circle((0,0), 1, color='b', fill=False)
ax.add_patch(circle)
ax.set_xticks([-1,-0.5,0,0.5,1])
ax.set_yticks([-1,-0.5,0,0.5,1])
ax.set_aspect('equal')
ax.scatter(z[:,0], z[:,1])
[ax.annotate(name, (z[i, 0], z[i, 1])) for i, name in enumerate(labels)]
ax.set_title('Time Budget Data')
ax.set_xlabel('First Factor - Expenditures')
ax.set_ylabel('Second Factor - Expenditures')
plt.show()

```

automatically created on 2024-04-25

### R Code
```r


# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# load data
x  = read.table("timebudget.dat")
n  = nrow(x)                            # number of rows
p  = ncol(x)                            # number of columns
x1 = sqrt((n - 1) * apply(x, 2, var))   # estimated std error for each variable
x2 = x - matrix(apply(as.matrix(x), 2, mean), nrow = n, ncol = p, byrow = T)  # X - mean(X)
x  = as.matrix(x2/matrix(x1, nrow = n, ncol = p, byrow = T))                  # Standardizes Data
e  = eigen(x %*% t(x)/n)                # Eigenvalues/Eigenvectors
e1 = e$values
e2 = e$vectors
a  = e2[, 1:2]                          # first two Eigenvectors corresponding to largest 2 Eigenvalues
w  = a * sqrt(matrix(e1[1:2], nrow(a), ncol(a), byrow = TRUE))                # coordinates of individuals

# Plot 1: the representation of the individuals
plot(w, type = "n", xlab = "First Factor - Individuals", ylab = "Second Factor - Individuals", 
    main = "Time Budget data", cex.lab = 1.2, cex.axis = 1.2, cex.main = 1.8, lwd = 2)
label = c("maus", "waus", "wnus", "mmus", "wmus", "msus", "wsus", "mawe", "wawe", 
    "wnwe", "mmwe", "wmwe", "mswe", "wswe", "mayo", "wayo", "wnyo", "mmyo", "wmyo", 
    "msyo", "wsyo", "maes", "waes", "wnes", "mmes", "wmes", "mses", "wses")
text(w, label, cex = 1.2)
abline(h = 0, v = 0)

g  = eigen(t(x) %*% x)  # Eigenvalues/Eigenvectors
g1 = g$values
g2 = g$vectors
b  = g2[, 1:2]          # first 2 vectors corresponding to largest 2 Eigenvalues
z  = b * sqrt(matrix(g1[1:2], nrow(b), ncol(b), byrow = TRUE))  # coordinates of variables
dev.new()

# Plot 2: the representation of the variables
ucircle = cbind(cos((0:360)/180 * pi), sin((0:360)/180 * pi))
plot(ucircle, type = "l", lty = "solid", col = "blue", xlab = "First Factor - Expenditures", 
    ylab = "Second Factor - Expenditures", main = "Time Budget data", cex.lab = 1.2, 
    cex.axis = 1.2, cex.main = 1.8, lwd = 2)
abline(h = 0, v = 0)
label = c("prof", "tran", "hous", "kids", "shop", "pers", "eati", "slee", "tele", 
    "leis")
text(z, label, cex = 1.2) 

```

automatically created on 2024-04-25

### SAS Code
```sas


* Import the data;
data timebudget;
  infile '/folders/myfolders/data/timebudget.dat';
  input temp1-temp10;
run;

proc iml;
  * Read data into a matrix;
  use timebudget;
    read all var _ALL_ into x; 
  close timebudget;
  
  n  = nrow(x); 
  p  = ncol(x);
  x  = (x - repeat(x(|:,|), n, 1)) / sqrt((n - 1) * var(x)); * standardizes the data;
  e  = x * x` / n;
  e1 = eigval(e);
  a  = eigvec(e)[, 1:2];  * first two Eigenvectors corresponding to largest 2 Eigenvalues;
  w  = a # sqrt(repeat(e1[1:2]`, nrow(a), 1)); *coordinates of individuals;
  
  g  = t(x) * x; 
  g1 = eigval(g);
  b  = eigvec(g)[, 1:2];  * first two Eigenvectors corresponding to largest 2 Eigenvalues;
  z  = b # sqrt(repeat(g1[1:2]`, nrow(b), 1)); *coordinates of variables;
  
  pi = constant("pi");
  uc = (cos((0:360)/180 * pi) // sin((0:360)/180 * pi))`;
  u1 = uc[,1];
  u2 = uc[,2];
  
  w1 = w[,1];
  w2 = w[,2];
  z1 = z[,1];
  z2 = z[,2];
  names1 = {"maus", "waus", "wnus", "mmus", "wmus", "msus", "wsus", "mawe", "wawe", 
    "wnwe", "mmwe", "wmwe", "mswe", "wswe", "mayo", "wayo", "wnyo", "mmyo", "wmyo", 
    "msyo", "wsyo", "maes", "waes", "wnes", "mmes", "wmes", "mses", "wses"};
  names2 = {"prof", "tran", "hous", "kids", "shop", "pers", "eati", "slee", "tele", 
    "leis"};
  create plot var {"w1" "w2" "z1" "z2" "u1" "u2" "names1" "names2"};
    append;
  close plot;
quit;

proc sgplot data = plot
    noautolegend;
  title 'Time Budget data';
  scatter x = w1 y = w2 / datalabel = names1 
    markerattrs = (color = blue);
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'First Factor - Individuals';
  yaxis label = 'Second Factor - Individuals';
run;

proc sgplot data = plot
    noautolegend;
  title 'Time Budget data';
  series  x = u1 y = u2 / lineattrs = (color = blue THICKNESS = 2);
  scatter x = z1 y = z2 / markerattrs = (color = blue)
    datalabel = names2;
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'First Factor - Expenditures';
  yaxis label = 'Second Factor - Expenditures';
run;





```

automatically created on 2024-04-25