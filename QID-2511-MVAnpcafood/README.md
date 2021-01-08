[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAnpcafood** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet: MVAnpcafood

Published in: Applied Multivariate Statistical Analysis

Description: Performs a PCA for the standardized French food data and shows the first two principal components for the individuals and the variables. The normalization corresponds to that of Lebart/Morineau/Fenelon.

Keywords: principal-components, pca, npca, eigenvalues, dimension-reduction, standardization, eigenvalue-decomposition, normalization, plot, graphical representation, data visualization, sas

See also: MVAnpcabanki, MVAnpcahous, MVAnpcahousi, MVAnpcatime, MVAnpcabank, MVAnpcausco, MVAnpcausco2, MVAnpcausco2i, MVAcpcaiv, MVApcabank, MVApcabanki, MVApcabankr, MVApcasimu

Author: Zografia Anastasiadou, Awdesch Melzer
Author[SAS]: Svetlana Bykovskaya
Author[Python]: 'Matthias Fengler, Liudmila Gorkun-Voevoda'

Submitted: Mon, September 08 2014 by Franziska Schulz
Submitted[SAS]: Wen, April 6 2016 by Svetlana Bykovskaya
Submitted[Python]: 'Wed, January 6 2021 by Liudmila Gorkun-Voevoda'

Datafile: food.dat

Example: 
- 1: Representation of the individuals.
- 2: Representation of the variables.

```

![Picture1](MVAnpcafood-1_python.png)

![Picture2](MVAnpcafood-1_sas.png)

![Picture3](MVAnpcafood-2_python.png)

![Picture4](MVAnpcafood-2_sas.png)

![Picture5](MVAnpcafood_1-1.png)

![Picture6](MVAnpcafood_2-1.png)

### PYTHON Code
```python

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

x = pd.read_csv("food.dat", sep = "\s+", header=None)

x = x.iloc[:, 1:]
x1 = np.sqrt((len(x) - 1) * (x.std()**2)/len(x))
x2 = x - np.tile(np.array(x.mean()), (len(x), 1))
x = x2/x1

e1, e2 = np.linalg.eig(x @ x.T/len(x))
a = e2[:, :2]
w = a * np.sqrt(np.tile(e1[:2], (len(a), 1)))

food = ["MA2", "EM2", "CA2", "MA3", "EM3", "CA3", "MA4", "EM4", "CA4", "MA5", 
        "EM5", "CA5"]

# Plot 1
fig, ax = plt.subplots(figsize = (7, 7))
ax.scatter(w[:, 0], -w[:, 1], c = "w")
for i in range(len(food)):
    ax.text(w[i, 0], -w[i, 1], food[i], fontsize = 12)

ax.vlines(0, -1, 1.2)
ax.hlines(0, -2, 1.2)

j = 0
for i in range(1, 5):
    ax.plot([w[j, 0], w[i, 0]], [-w[j, 1], -w[i, 1]], linestyle = "dashed", c = "black")
    j = np.abs(j-1)
ax.plot([w[3, 0], w[4, 0]], [-w[3, 1], -w[4, 1]], linestyle = "dashed", c = "black")
ax.plot([w[3, 0], w[6, 0]], [-w[3, 1], -w[6, 1]], linestyle = "dashed", c = "black")
ax.plot([w[4, 0], w[5, 0]], [-w[4, 1], -w[5, 1]], linestyle = "dashed", c = "black")
ax.plot([w[4, 0], w[7, 0]], [-w[4, 1], -w[7, 1]], linestyle = "dashed", c = "black")
ax.plot([w[5, 0], w[8, 0]], [-w[5, 1], -w[8, 1]], linestyle = "dashed", c = "black")
ax.plot([w[6, 0], w[7, 0]], [-w[6, 1], -w[7, 1]], linestyle = "dashed", c = "black")
ax.plot([w[6, 0], w[9, 0]], [-w[6, 1], -w[9, 1]], linestyle = "dashed", c = "black")
ax.plot([w[7, 0], w[8, 0]], [-w[7, 1], -w[8, 1]], linestyle = "dashed", c = "black")
ax.plot([w[7, 0], w[10, 0]], [-w[7, 1], -w[10, 1]], linestyle = "dashed", c = "black")
ax.plot([w[8, 0], w[11, 0]], [-w[8, 1], -w[11, 1]], linestyle = "dashed", c = "black")
ax.plot([w[9, 0], w[10, 0]], [-w[9, 1], -w[10, 1]], linestyle = "dashed", c = "black")
ax.plot([w[10, 0], w[11, 0]], [-w[10, 1], -w[11, 1]], linestyle = "dashed", c = "black")

ax.set_xlim(-1.5, 1.1)
ax.set_ylim(-0.6, 1)
ax.set_xlabel("First Factor - Families")
ax.set_ylabel("Second Factor - Families")
plt.title("French Food data", fontsize = 14)
plt.show()


g1, g2 = np.linalg.eig(x.T @ x/len(x))
b = g2[:, :2]
z = b * np.sqrt(np.tile(g1[:2], (b.shape[0], 1)))

# Plot 2
ucircle = np.array([np.cos((np.arange(0, 361)/180)*np.pi), 
                    np.sin((np.arange(0, 361)/180)*np.pi)])

fig, ax = plt.subplots(figsize = (7, 7))
ax.plot(ucircle[0], ucircle[1])

ax.scatter(-z[:, 0], z[:, 1], c = "w")
label = ["bread", "vegetables", "fruits", "meat", "poultry", "milk", "wine"]
for i in range(len(label)):
    ax.text(-z[i, 0], z[i, 1], label[i], fontsize = 12)

ax.axvline(0, c = "k")
ax.axhline(0, c = "k")

ax.set_xlabel("First Factor - Goods")
ax.set_ylabel("Second Factor - Goods")
plt.title("French Food data", fontsize = 14)
plt.show()


```

automatically created on 2021-01-08

### R Code
```r


# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# load data
x  = read.table("food.dat")
p  = ncol(x)
n  = nrow(x)
x  = x[, 2:p]
x1 = sqrt((n - 1) * apply(x, 2, var)/n)
x2 = x - matrix(apply(as.matrix(x), 2, mean), nrow = n, ncol = p - 1, byrow = T)
x  = as.matrix(x2/matrix(x1, nrow = n, ncol = p - 1, byrow = T))  # standardizes the data matrix

# compute eigenvalues
e  = eigen(x %*% t(x)/n)
e1 = e$values
e2 = e$vectors
a  = e2[, 1:2]
w  = -a * sqrt(matrix(e1[1:2], nrow(a), ncol(a), byrow = TRUE))

# Plot 1: the representation of the individuals
dev.new()
plot(w, type = "n", xlab = "First Factor - Families", ylab = "Second Factor - Families", 
    main = "French Food data", cex.lab = 1.2, cex.axis = 1.2, cex.main = 1.8, lwd = 2)
text(w, c("MA2", "EM2", "CA2", "MA3", "EM3", "CA3", "MA4", "EM4", "CA4", "MA5", "EM5", 
    "CA5"), cex = 1.2)
abline(h = 0, v = 0)
segments(w[1, 1], w[1, 2], w[2, 1], w[2, 2], lty = 3, lwd = 2)
segments(w[2, 1], w[2, 2], w[3, 1], w[3, 2], lty = 3, lwd = 2)
segments(w[1, 1], w[1, 2], w[4, 1], w[4, 2], lty = 3, lwd = 2)
segments(w[2, 1], w[2, 2], w[5, 1], w[5, 2], lty = 3, lwd = 2)
segments(w[4, 1], w[4, 2], w[5, 1], w[5, 2], lty = 3, lwd = 2)
segments(w[5, 1], w[5, 2], w[6, 1], w[6, 2], lty = 3, lwd = 2)
segments(w[6, 1], w[6, 2], w[9, 1], w[9, 2], lty = 3, lwd = 2)
segments(w[8, 1], w[8, 2], w[9, 1], w[9, 2], lty = 3, lwd = 2)
segments(w[5, 1], w[5, 2], w[8, 1], w[8, 2], lty = 3, lwd = 2)
segments(w[7, 1], w[7, 2], w[8, 1], w[8, 2], lty = 3, lwd = 2)
segments(w[4, 1], w[4, 2], w[7, 1], w[7, 2], lty = 3, lwd = 2)
segments(w[7, 1], w[7, 2], w[10, 1], w[10, 2], lty = 3, lwd = 2)
segments(w[8, 1], w[8, 2], w[11, 1], w[11, 2], lty = 3, lwd = 2)
segments(w[9, 1], w[9, 2], w[12, 1], w[12, 2], lty = 3, lwd = 2)
segments(w[10, 1], w[10, 2], w[11, 1], w[11, 2], lty = 3, lwd = 2)
segments(w[11, 1], w[11, 2], w[12, 1], w[12, 2], lty = 3, lwd = 2)

g  = eigen(t(x) %*% x/n)
g1 = g$values
g2 = g$vectors
b  = g2[, 1:2]
z  = b * sqrt(matrix(g1[1:2], nrow(b), ncol(b), byrow = TRUE))

# Plot 2: the representation of the variables
dev.new()
ucircle = cbind(cos((0:360)/180 * pi), sin((0:360)/180 * pi))
plot(ucircle, type = "l", lty = "solid", col = "blue", xlim = c(-1.05, 1.05), ylim = c(-1.05, 
    1.05), xlab = "First Factor - Goods", ylab = "Second Factor - Goods", main = "French Food data", 
    cex.lab = 1.2, cex.axis = 1.2, cex.main = 1.8, lwd = 2)
abline(h = 0, v = 0)
label = c("bread", "vegetables", "fruits", "meat", "poultry", "milk", "wine")
text(z, label) 

```

automatically created on 2021-01-08

### SAS Code
```sas


* Import the data;
data food;
  infile '/folders/myfolders/data/food.dat';
  input temp1 $ temp2-temp8;
run;

proc iml;
  * Read data into a matrix;
  use food;
    read all var _ALL_ into x; 
  close food;
  
  n = nrow(x);
  p = ncol(x);
  
  x1 = sqrt((n - 1) * var(x)/n);
  x2 = x - repeat(x(|:,|), n, 1);
  x = x2 / repeat(x1, n, 1); * standardizes the data matrix;
  
  *  compute eigenvalues;
  e  = x * x`/n;
  e1 = eigval(e);
  e2 = eigvec(e);
  a  = e2[, 1:2];
  w  = - a # sqrt(repeat(e1[1:2]`, nrow(a),1));
  
  x1  = w[,1];
  x2  = w[,2]; 
  names = {"MA2", "EM2", "CA2", "MA3", 
           "EM3", "CA3", "MA4", "EM4", 
           "CA4", "MA5", "EM5", "CA5"};
  z1 = w[1,] // w[4,] // w[7,] // w[10,] // w[11,] // w[12,] // w[9,] // w[6,] //
       w[3,] // w[2,] // w[1,];
  z2 = w[4,] // w[5,] // w[8,] // w[11,];
  z3 = w[7,] // w[8,] // w[9,];
  z4 = w[3,] // w[5,] // w[2,];

  x3  = z1[,1];
  x4  = z1[,2]; 
  x5  = z2[,1];
  x6  = z2[,2];
  x7  = z3[,1];
  x8  = z3[,2];
  x9  = z4[,1];
  x10 = z4[,2];
  
  food = {"bread", "vegetables", "fruits", "meat", "poultry", "milk", "wine"};
  g  = x` * x / n;
  g1 = eigval(g);
  g2 = eigvec(g);
  b  = g2[, 1:2];
  z  = b # sqrt(repeat(g1[1:2]`, nrow(b),1));
  
  y1 = z[,1];
  y2 = -z[,2];
 
  pi = constant("pi");
  uc = (cos((0:360)/180 * pi) // sin((0:360)/180 * pi))`;
  u1 = uc[,1];
  u2 = uc[,2];
  
  create plot var {"x1" "x2" "x3" "x4" "x5" "x6" "x7" "x8" "x9" "x10" "names"
                   "y1" "y2" "u1" "u2" "food"};
    append;
  close plot;
quit;

proc sgplot data = plot
    noautolegend;
  title 'French Food data';
  scatter x = x1 y = x2 / markerattrs = (symbol = circlefilled)
    datalabel = names;
  series x = x3 y = x4 / 
    lineattrs = (color = black THICKNESS = 2 pattern = shortdash);
  series x = x5 y = x6 / 
    lineattrs = (color = black THICKNESS = 2 pattern = shortdash);
  series x = x7 y = x8 / 
    lineattrs = (color = black THICKNESS = 2 pattern = shortdash);
  series x = x9 y = x10 / 
    lineattrs = (color = black THICKNESS = 2 pattern = shortdash);
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'First Factor - Families';
  yaxis label = 'Second Factor - Families';
run;

proc sgplot data = plot
    noautolegend;
  title 'French Food data';
  series  x = u1 y = u2 / lineattrs = (color = blue THICKNESS = 2);
  scatter x = y1 y = y2 / markerattrs = (color = black symbol = circlefilled)
    datalabel = food;
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'First Factor - Goods';
  yaxis label = 'Second Factor - Goods';
run;
```

automatically created on 2021-01-08