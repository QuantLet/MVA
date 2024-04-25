[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="1100" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAnpcabanki** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet: MVAnpcabanki

Published in: Applied Multivariate Statistical Analysis

Description: Shows a screeplot of the eigenvalues for the PCA of the standardized Swiss bank notes. Additionally, it computes the correlations between the variables and the principal components and displays the first two of them.

Keywords: principal-components, pca, npca, eigenvalues, standardization, correlation, screeplot, plot, graphical representation, data visualization, sas

See also: MVAnpcabank, MVAnpcahous, MVAnpcahousi, MVAnpcatime, MVAnpcafood, MVAnpcausco, MVAnpcausco2, MVAnpcausco2i, MVAcpcaiv, MVApcabank, MVApcabanki, MVApcabankr, MVApcasimu

Author: Zografia Anastasiadou
Author[SAS]: Svetlana Bykovskaya
Author[Python]: Matthias Fengler, Tim Dass

Submitted: Tue, March 11 2014 by Awdesch Melzer
Submitted[SAS]: Wen, April 6 2016 by Svetlana Bykovskaya
Submitted[Python]: Tue, April 23 2024 by Tim Dass

Datafile: bank2.dat

Example: 
- 1: Screeplot of the eigenvalues for the PCA of the standardized Swiss bank notes.
- 2: The correlations of the original variables with the PCs.

```

![Picture1](MVAnpcabanki-1_python.png)

![Picture2](MVAnpcabanki-1_sas.png)

![Picture3](MVAnpcabanki-2_python.png)

![Picture4](MVAnpcabanki-2_sas.png)

![Picture5](MVAnpcabanki_1-1.png)

![Picture6](MVAnpcabanki_2-1.png)

### PYTHON Code
```python

#works on numpy 1.25.2, pandas 2.1.1 and matplotlib 3.8.0
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.patches import Circle

x = pd.read_csv("bank2.dat", sep = "\s+", header=None)
x = (x-x.mean())/x.std()
cov_matrix = np.cov(x, rowvar=False)
e,v = np.linalg.eig(cov_matrix)
r = np.dot(x,v)
r = np.corrcoef(np.column_stack((r, x)), rowvar=False)
r1 = r[6:12,0:2]

fig, ax = plt.subplots(figsize=(6,4))

ax.scatter(range(1,7), e, c='b', s= 110)
ax.set_title('Swiss Bank Notes')
ax.set_xlabel('Index')
ax.set_ylabel('Lambda')

plt.show()

names = [f'X{i}' for i in range(1, 7)]
fig, ax = plt.subplots(figsize=(6,6))
ax.plot([0,0],[-1,1], color='grey', alpha=0.5)
ax.plot([-1,1],[0,0], color='grey', alpha=0.5)
ax.set_ylim(-1,1)
ax.set_xlim(-1,1)
circle = Circle((0,0), 1, color='b', fill=False)
ax.add_patch(circle)
ax.set_xticks([-1,-0.5,0,0.5,1])
ax.set_yticks([-1,-0.5,0,0.5,1])
ax.set_aspect('equal')
ax.scatter(r1[:,0], r1[:,1])
for i, name in enumerate(names):
    ax.annotate(name, (r1[i,0], r1[i,1]))
ax.set_xlabel('first PC')
ax.set_ylabel('second PC')
ax.set_title('Swiss Bank Notes')

plt.show()

```

automatically created on 2024-04-25

### R Code
```r


# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# load data
x = read.table("bank2.dat")

x  = scale(x)       # standardizes the data matrix
n  = nrow(x)
e  = eigen(cov(x))  # calculates eigenvalues and eigenvectors and sorts them by size
e1 = e$values

# Plot 1: the relative proportion of variance explained by PCs
dev.new()
plot(e1, xlab = "Index", ylab = "Lambda", main = "Swiss Bank Notes", cex.lab = 1.2, 
    cex.axis = 1.2, cex.main = 1.8)
m    = mean(x)
temp = as.matrix(x - matrix(m, n, ncol(x), byrow = T))
r    = temp %*% e$vectors
r    = cor(cbind(r, x))      # correlation between PCs and variables
r1   = r[7:12, 1:2]          # correlation of the two most important PCs and variables

# Plot 2: the correlations of the original variables with the PCs
dev.new()
ucircle = cbind(cos((0:360)/180 * pi), sin((0:360)/180 * pi))
plot(ucircle, type = "l", lty = "solid", col = "blue", xlab = "First PC", ylab = "Second PC", 
    main = "Swiss Bank Notes", cex.lab = 1.2, cex.axis = 1.2, cex.main = 1.8, lwd = 2)
abline(h = 0, v = 0)
label = c("X1", "X2", "X3", "X4", "X5", "X6")
text(r1, label, cex = 1.2) 

```

automatically created on 2024-04-25

### SAS Code
```sas


* Import the data;
data b2;
  infile '/folders/myfolders/Sas-work/data/bank2.dat';
  input x1-x6;
run;

* standardize the data matrix;
proc standard data = b2 mean = 0 std = 1 out = y;
  var x1 x2 x3 x4 x5 x6;
run;

proc iml;
  * Read data into a matrix;
  use y;
    read all var _ALL_ into x; 
  close y;
  
  n  = nrow(x);
  e  = cov(x);
  e2 = eigval(e);
  e1 = 1:nrow(e2);
  
  m  = x[:];
  t  = x - repeat(m, n, ncol(x));
  r  = t * eigvec(e);
  r  = corr(r || x);    * correlation between PCs and variables;
  r  = r[7:12, 1:2];    * correlation of the two most important PCs and variables;
  
  r1 = -r[,1];
  r2 = r[,2];
  
  pi = constant("pi");
  uc = (cos((0:360)/180 * pi) // sin((0:360)/180 * pi))`;
  u1 = uc[,1];
  u2 = uc[,2];
  names = {"X1", "X2", "X3", "X4", "X5", "X6"};

  create plot var {"e1" "e2" "u1" "u2" "r1" "r2" "names"};
    append;
  close plot;
quit;

* Plot 1: the relative proportion of variance explained by PCs;
proc sgplot data = plot
    noautolegend;
  title 'Eigenvalues of S';
  scatter x = e1 y = e2 / markerattrs = (color = blue);
  xaxis label = 'Index';
  yaxis label = 'Lambda';
run;

* Plot 2: the correlations of the original variables with the PCs;
proc sgplot data = plot
    noautolegend;
  title 'Swiss Bank Notes';
  series  x = u1 y = u2 / lineattrs = (color = blue THICKNESS = 2);
  scatter x = r1 y = r2 / markerattrs = (color = black symbol = circlefilled)
    datalabel = names;
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'First PC';
  yaxis label = 'Second PC';
run;

   
```

automatically created on 2024-04-25