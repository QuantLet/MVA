
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAspecdecomp** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVAspecdecomp

Published in : Applied Multivariate Statistical Analysis

Description : Performs a spectral decomposition of a 2 by 2 covariance matrix.

Keywords : covariance, decomposition, eigenvalues, eigenvectors, spectral, sas

Author : Wolfgang K. Haerdle

Author[SAS] : Svetlana Bykovskaya

Submitted : Mon, September 15 2014 by Felix Jung

Submitted[SAS] : Wen, April 6 2016 by Svetlana Bykovskaya

Input: 
- rho: Covariance of the two variables being considered.

Output : '2 x 2- Difference between the covariance matrix a and its spectral decomposition. Should
be very close to zero.'

```


### R Code:
```r

# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

rho = 0.9  # Set the covariance
a = cbind(c(1, rho), c(rho, 1))  # Covariance matrix
e = eigen(a)  # Perform spectral decomposition
lambda = diag(e$values)  # Diagonal matrix of eigenvalues
gamma = e$vectors  # Gamma transformation matrix

# Check whether the decomposition yiels a
a - gamma %*% lambda %*% t(gamma)  # Should yield a matrix of zeros (approx)

```

### SAS Code:
```sas

proc iml; 
  rho = 0.9;                             * Set the covariance;
  a = ({1} || rho ) // (rho || {1});     * Covariance matrix;
  lambda = diag(eigval(a));              * Diagonal matrix of eigenvalues;
  gamma = eigvec(a);                     * Gamma transformation matrix;
  
  * Check whether the decomposition yiels a;
  p = a - gamma * lambda * gamma`;      * Should yield a matrix of zeros (approx);
  print p; 
quit;
```
