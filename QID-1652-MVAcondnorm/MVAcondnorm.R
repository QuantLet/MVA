
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("scatterplot3d")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# input parameters
Sigma = matrix(c(1, -0.8, -0.8, 2), 2, 2)                            # Covariance matrix of the Bivariate Normal distribution
c = sqrt(Sigma[2, 2] - Sigma[2, 1] * 1/(Sigma[1, 1]) * Sigma[1, 2])  # SD of conditional f(X2|X1)

# Create grid for x1,x2 and compute conditional pdf

x1  = rep(seq(0, 4.5, by = 0.75), times = 301)                # grid values for x1\t\t
x2  = rep(seq(-10, 5, by = 0.05), each = length(unique(x1)))  # grid values for x2
f   = dnorm(0, (x2 - Sigma[1, 1]/Sigma[1, 2] * x1)/c, 1)/c    # conditional pdf f(X2|X1)
xx1 = cbind(x1, x2, f)

# Conditional means
xm  = unique(x1)                                              # realized x1
m   = cbind(xm, Sigma[2, 1] * xm, rep(0, length(xm)))         # conditional mean
xmf = c(-2, xm, 6)

# plot: shifts in the conditional density
s3d = scatterplot3d(xx1[, 2], xx1[, 1], xx1[, 3], lwd = 0.05, pch = 20, ylab = "", 
    xlab = "", zlab = "", scale.y = 0.7, cex.axis = 1.1, angle = 40)
s3d$points3d(m[, 2], m[, 1], m[, 3], pch = 3, col = "red3", lwd = 2)
s3d$points3d(Sigma[2, 1] * xmf, xmf, rep(0, 9), type = "l", col = "black", lwd = 2)

title("Conditional Normal Densities f(X2|X1)")