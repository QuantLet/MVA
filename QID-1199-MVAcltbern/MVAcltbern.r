
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("KernSmooth")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

p = 0.5
n = 35
bsample  = rbinom(n * 1000, 1, 0.5)       # Random generation of the binomial distribution with parameters 1000*n and 0.5
bsamplem = matrix(bsample, n, 1000)       # Create a matrix of binomial random variables
bden     = bkde((colMeans(bsamplem) - p)/sqrt(p * (1 - p)/n))  # Compute kernel density estimate

# Plot
plot(bden, col = "blue3", type = "l", lty = 1, lwd = 4, xlab = "1000 Random Samples", 
    ylab = "Estimated and Normal Density", cex.lab = 1, cex.axis = 1, ylim = c(0, 
        0.45))
lines(bden$x, dnorm(bden$x), col = "red3", lty = 1, lwd = 4)  
title(paste("Asymptotic Distribution, n =", n)) 
