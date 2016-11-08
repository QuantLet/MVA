
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("grid", "lattice")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# reproduction of matrix of coordinates Creating a function for reproduction of
# coordinates
f = function(u, v, theta) {
    exp(-((-log(u))^theta + (-log(v))^theta)^(1/theta))
}

N     = 21
v     = (u <- seq(0, 1, by = 0.05))
uu    = rep(u, N)
vv    = rep(v, each = N)
theta = 3
w     = matrix(f(uu, vv, theta), nr = N)

persp(w, lwd = 3, cex.axis = 2, cex.lab = 2, scale = T) 
title(paste("3D surface plot "))
