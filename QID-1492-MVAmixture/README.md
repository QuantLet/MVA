[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="1100" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAmixture** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet: MVAmixture

Published in: Applied Multivariate Statistical Analysis

Description: Plots probability density functions and cumulative density functions of Gaussian mixture and Gaussian distributions.

Keywords: gaussian, plot, graphical representation, distribution, pdf, cdf, probability, density, multivariate, heavy-tailed, sas

Author: Wolfgang K. Haerdle
Author[SAS]: Svetlana Bykovskaya
Author[Python]: Matthias Fengler, Tim Dass

Submitted: Thu, February 02 2012 by Dedy Dwi Prastyo
Submitted[SAS]: Wen, April 6 2016 by Svetlana Bykovskaya
Submitted[Python]: Tue, April 16 2024 by Tim Dass

```

![Picture1](MVAmixture-1_sas.png)

![Picture2](MVAmixture-2_sas.png)

![Picture3](MVAmixture01_python.png)

![Picture4](MVAmixture02_python.png)

![Picture5](MVAmixture_1.png)

![Picture6](MVAmixture_2.png)

### PYTHON Code
```python

# works on numpy 1.23.5, scipy 1.10.0 and matplotlib 3.6.2
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm

xx = np.arange(-6, 6, 0.1)
pdfm = (1/(5* (2*np.pi)**0.5))* (4* np.exp(-xx**2/2) + (1/3)*np.exp(-xx**2/18))

fig1, ax1 = plt.subplots(1,1,figsize=(10, 10))

ax1.plot(xx, pdfm, 'b-', linewidth=3, label='mixture')
ax1.plot(xx, norm.pdf(xx), 'r-', linewidth=3, label='gaussian')
ax1.set_xlabel('X', fontsize=16)
ax1.set_ylabel('Y', fontsize=16)
ax1.set_title('PDF of a Gaussian mixture and distribution', fontsize=23)
fig1.legend(fontsize=18, loc =(0.77, 0.45))

plt.tight_layout()
plt.show()

cdfm = 0.8 * norm.cdf(xx, scale = 0.1) + 0.2 * norm.cdf(xx, scale = 0.9)

fig2, ax2 = plt.subplots(1,1,figsize=(10, 10))

ax2.plot(xx, cdfm, 'b-', linewidth=3, label='mixture')
ax2.plot(xx, norm.cdf(xx), 'r-', linewidth=3, label='gaussian')
ax2.set_xlabel('X', fontsize=16)
ax2.set_ylabel('Y', fontsize=16)
ax2.set_title('CDF of a Gaussian mixture and distribution', fontsize=23)
fig2.legend(fontsize=18, loc =(0.77, 0.45))

plt.tight_layout()
plt.show()
```

automatically created on 2024-04-25

### R Code
```r


# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# Gaussian Mixture and Gaussian distribution
gaussian = function(x, y) {
    y = 1/(5 * (2 * pi)^(1/2)) * (4 * exp(-x^2/2) + 1/3 * exp(-x^2/18))
    return(y)
}
xx = seq(-6, 6, by = 0.1)

# Plot of Gaussian PDF
plot(xx, gaussian(xx), type = "l", col = "blue", ylim = c(0, 0.4), ylab = "Y", xlab = "X", 
    lwd = 3, cex.lab = 2, cex.axis = 2)
lines(seq(-5, 5, 0.01), dnorm(seq(-5, 5, 0.01)), type = "l", col = "red", lwd = 3)
legend(x = 0.75, y = 0.25, legend = c("Gaussian Mixture", "Gaussian distribution"), 
    pch = c(20, 20), col = c("blue", "red"), bty = "n")
title("Pdf of a Gaussian mixture and Gaussian distribution")

xx = seq(-6, 6, by = 0.1)
gaussian = function(x, y) {
    y = 0.8 * pnorm(xx, mean = 0, sd = 0.1) + 0.2 * pnorm(xx, mean = 0, sd = 0.9)
    return(y)
}

# Plot of Gaussian CDF
dev.new()
plot(xx, gaussian(xx), type = "l", col = "red", ylim = c(0, 1), ylab = "Y", xlab = "X", 
    cex.lab = 2, cex.axis = 2, lwd = 3)
lines(xx, pnorm(xx, mean = 0, sd = 1), type = "l", col = "blue", lwd = 3)
legend(x = 0.75, y = 0.25, legend = c("Gaussian Mixture", "Gaussian distribution"), 
    pch = c(20, 20), col = c("red", "blue"), bty = "n")

title("Cdf of a Gaussian mixture and Gaussian distribution") 

```

automatically created on 2024-04-25

### SAS Code
```sas

data pdf;
  pi = constant("pi");
  do x = -6 to 6 by 0.1;
    p1 = pdf("Normal", x);
    p2 = 1/(5 * (2 * pi) ** (1/2)) * (4 * exp(-x ** 2/2) + 1/3 * exp(-x ** 2/18));
    c1 = cdf("Normal", x);
    c2 = 0.8 * cdf("Normal", x, 0, 0.1) + 0.2 * cdf("Normal", x, 0, 0.9);
    output;
  end;
run;
 
* Plot of Gaussian PDF;
proc sgplot data = pdf;
  title 'Pdf of a Gaussian mixture and Gaussian distribution';
  series x = x y = p1 / legendlabel = 'Gaussian distribution' lineattrs = (color = red thickness = 2);
  series x = x y = p2 / legendlabel = 'Gaussian Mixture' lineattrs = (color = blue thickness = 2);
  xaxis label = "X"; 
  yaxis min = 0 max = 0.4 label = "Y";
run;

* Plot of Gaussian CDF;
proc sgplot data = pdf;
  title 'Cdf of a Gaussian mixture and Gaussian distribution';
  series x = x y = c1 / legendlabel = 'Gaussian distribution' lineattrs = (color = red thickness = 2);
  series x = x y = c2 / legendlabel = 'Gaussian Mixture' lineattrs = (color = blue thickness = 2);
  xaxis label = "X"; 
  yaxis min = 0 max = 1 label = "Y";
run;
```

automatically created on 2024-04-25