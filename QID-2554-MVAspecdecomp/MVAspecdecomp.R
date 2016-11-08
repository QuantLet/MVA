
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
