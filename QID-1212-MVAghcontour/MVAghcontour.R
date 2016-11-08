
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# Gumbel H Copula is defined as: C(u,v) = exp - ( (-log u)^theta + (-log
# v)^theta )^(1/theta)

f = function(u, v, theta) {
    exp(-((-log(u))^theta + (-log(v))^theta)^(1/theta))
}

N = 21
v = u = seq(0, 1, by = 0.05)
uu = rep(u, N)
vv = rep(v, each = N)
op = par(mfrow = c(2, 3))
theta = 1

# Contour plots with different theta parameters
w = matrix(f(uu, vv, theta), nr = N)
contour(w, cex.axis = 2, cex.lab = 2, main = "Theta 1.000", xlab = "u", ylab = "v", 
    xlim = c(0, 1), ylim = c(0, 1))
theta = 2

w = matrix(f(uu, vv, theta), nr = N)
contour(w, cex.axis = 2, cex.lab = 2, main = "Theta 2.000", xlab = "u", ylab = "v", 
    xlim = c(0, 1), ylim = c(0, 1))
theta = 3

w = matrix(f(uu, vv, theta), nr = N)
contour(w, cex.axis = 2, cex.lab = 2, main = "Theta 3.000", xlab = "u", ylab = "v", 
    xlim = c(0, 1), ylim = c(0, 1))
theta = 10

w = matrix(f(uu, vv, theta), nr = N)
contour(w, cex.axis = 2, cex.lab = 2, main = "Theta 10.000", xlab = "u", ylab = "v", 
    xlim = c(0, 1), ylim = c(0, 1))
theta = 30

w = matrix(f(uu, vv, theta), nr = N)
contour(w, cex.axis = 2, cex.lab = 2, main = "Theta 30.000", xlab = "u", ylab = "v", 
    xlim = c(0, 1), ylim = c(0, 1))
theta = 100

w = matrix(f(uu, vv, theta), nr = N)
contour(w, cex.axis = 2, cex.lab = 2, main = "Theta 100.000", xlab = "u", ylab = "v", 
    xlim = c(0, 1), ylim = c(0, 1))

par(op)