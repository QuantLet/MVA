[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAclus8p** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet: MVAclus8p

Published in: Applied Multivariate Statistical Analysis

Description: Performs cluster analysis for 8 data points.

Keywords: cluster-analysis, plot, graphical representation, distance, euclidean, dendrogram, sas

See also: MVAclusfood, MVAclusbank, MVAspecclust, MVAclusbh, MVAclususcrime, SMSclus8p, SMSclus8pd, SMSclus8pmst2, SMSclusbank, SMScluscomp, SMScluscrime, SMScluscrimechi2, SMSclushealth

Author: Zografia Anastasiadou
Author[SAS]: Svetlana Bykovskaya
Author[Python]: Matthias Fengler, Liudmila Gorkun-Voevoda

Submitted: Thu, September 11 2014 by Franziska Schulz
Submitted[SAS]: Mon, March 14 2016 by Svetlana Bykovskaya
Submitted[Python]: Wed, September 9 2020 by Liudmila Gorkun-Voevoda

Example: 
- 1: The dendrogram for the 8-point example after Single linkage algorithm.
- 2: The 8-point example.

```

![Picture1](MVAclus8p-1_python.png)

![Picture2](MVAclus8p-1_sas.png)

![Picture3](MVAclus8p-2_python.png)

![Picture4](MVAclus8p-2_sas.png)

![Picture5](MVAclus8p_1-1.png)

![Picture6](MVAclus8p_2-1.png)

### PYTHON Code
```python

import numpy as np
import matplotlib.pyplot as plt
from scipy.cluster import hierarchy


eight = np.array(([-3, -2, -2, -2, 1, 1, 2, 4], [0, 4, -1, -2, 4, 2, -4, -3])).T
eight = eight[[7,6,2,0,3,1,5,4], :]


fig, ax = plt.subplots(figsize = (10, 10))

plt.xlim(-4.2, 4.2)
plt.ylim(-4.2, 4.2)
plt.title("8 points", fontsize = 16)
plt.ylabel("brand loyalty")
plt.xlabel("price conciousness")

plt.plot([eight[0, 0], eight[1, 0]], [eight[0, 1], eight[1, 1]], c = "black", zorder = 0)
plt.plot([eight[1, 0], eight[4, 0]], [eight[1, 1], eight[4, 1]], c = "black", zorder = 0)
plt.plot([eight[4, 0], eight[2, 0]], [eight[4, 1], eight[2, 1]], c = "black", zorder = 0)
plt.plot([eight[2, 0], eight[3, 0]], [eight[2, 1], eight[3, 1]], c = "black", zorder = 0)
plt.plot([eight[2, 0], eight[6, 0]], [eight[2, 1], eight[6, 1]], c = "black", zorder = 0)
plt.plot([eight[6, 0], eight[7, 0]], [eight[6, 1], eight[7, 1]], c = "black", zorder = 0)
plt.plot([eight[7, 0], eight[5, 0]], [eight[7, 1], eight[5, 1]], c = "black", zorder = 0)

plt.scatter(eight[:, 0], eight[:, 1], c = "w", edgecolors = "black", s = 500)
for i in range(0, 8):
    plt.text(eight[i, 0]-0.1, eight[i, 1]-0.1, str(i), fontsize = 20, color = "r")

plt.show()


d = np.zeros([8,8])

for i in range(0, 8):
    for j in range(0, 8):
        d[i, j] = np.linalg.norm(eight[i, :] - eight[j, :])

dd = (d**2)

ddd  = dd[1:, :-1][:, 0]
for i in range(1, 7):
    ddd = np.concatenate((ddd, dd[1:, :-1][i:, i]))

Z = hierarchy.linkage(ddd, 'single')


fig, ax = plt.subplots(figsize = (10, 10))
h = hierarchy.dendrogram(Z)
plt.title("Single Linkage Dendrogram - 8 points", fontsize = 16)
plt.ylabel("Squared Euclidean Distance")
plt.show()


```

automatically created on 2020-09-10

### R Code
```r


# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# create matrix from 8 data points and define eight points
eight = cbind(c(-3, -2, -2, -2, 1, 1, 2, 4), c(0, 4, -1, -2, 4, 2, -4, -3))
eight = eight[c(8, 7, 3, 1, 4, 2, 6, 5), ]

# Plot 1: The 8-point example
plot(eight, type = "n", xlab = "price conciousness", ylab = "brand loyalty", xlim = c(-4, 
    4), main = "8 points")
segments(eight[1, 1], eight[1, 2], eight[2, 1], eight[2, 2], lwd = 2)
segments(eight[2, 1], eight[2, 2], eight[5, 1], eight[5, 2], lwd = 2)
segments(eight[5, 1], eight[5, 2], eight[3, 1], eight[3, 2], lwd = 2)
segments(eight[3, 1], eight[3, 2], eight[4, 1], eight[4, 2], lwd = 2)
segments(eight[3, 1], eight[3, 2], eight[7, 1], eight[7, 2], lwd = 2)
segments(eight[7, 1], eight[7, 2], eight[8, 1], eight[8, 2], lwd = 2)
segments(eight[8, 1], eight[8, 2], eight[6, 1], eight[6, 2], lwd = 2)
points(eight, pch = 21, cex = 2.7, bg = "white")
text(eight, as.character(1:8), col = "red3", xlab = "first coordinate", ylab = "second coordinate", 
    main = "8 points", cex = 1)

d  = dist(eight, method = "euclidean", p = 2)  # euclidean distance matrix
dd = d^2                                       # squared euclidean distance matrix
s  = hclust(dd, method = "single")             # cluster analysis with single linkage algorithm                      

# Plot 2: The dendrogram for the 8-point example, Single linkage algorithm.
dev.new()
plot(s, hang = -0.1, frame.plot = TRUE, ann = FALSE)
title(main = "Single Linkage Dendrogram - 8 points", ylab = "Squared Euclidean Distance") 

```

automatically created on 2020-09-10

### SAS Code
```sas


proc iml;
  * create matrix from 8 data points and define eight points;
  eight = {-3, -2, -2, -2, 1, 1, 2, 4} || {0, 4, -1, -2, 4, 2, -4, -3};
  eight = eight[{8, 7, 3, 1, 4, 2, 6, 5}, ];
  
  id = 1:8;
  w  = eight;
  z  = w[1,] // w[2,] // w[5,] // w[3,] // w[4,] // w[3,] //w[7,] // w[8,] // w[6,];
  
  x1 = w[,1];
  x2 = w[,2];
  x3 = z[,1];
  x4 = z[,2];
  
  create plot var {"x1" "x2" "x3" "x4" "id"};
    append;
  close plot;
quit;

proc sgplot data = plot
    noautolegend;
  title '8 points';
  scatter x = x1 y = x2 / markerattrs = (symbol = circlefilled color = red)
    datalabel = id;
  series x = x3 y = x4 / 
    lineattrs = (color = black THICKNESS = 2);
  xaxis label = 'price conciousness';
  yaxis label = 'brand loyalty';
run;

proc distance data = plot(obs = 8) out = dist method = sqeuclid nostd;
   var interval(x1 x2);
run;

data newdist;
  set dist;
  set plot;
  drop x1 x2 x3 x4;
run;

ods graphics on;
proc cluster data = newdist(type = distance)
    method = single
    plots(only) = (Pseudo Dendrogram(vertical))
    print = 0;
  id id;
run;
ods graphics off;


```

automatically created on 2020-09-10