
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# Intercity road distances
ber  = c(0, 214, 279, 610, 596, 237)
dre  = c(214, 0, 492, 533, 496, 444)
ham  = c(279, 492, 0, 520, 772, 140)
kob  = c(610, 533, 520, 0, 521, 687)
mue  = c(596, 496, 772, 521, 0, 771)
ros  = c(237, 444, 140, 687, 771, 0)

dist = cbind(ber, dre, ham, kob, mue, ros)

# a, b, h, i, r, x, xx1, xx2 are matrices
a    = (dist^2) * (-0.5)
i    = diag(6)
u    = rep(1, 6)
h    = i - (1/6 * (u %*% t(u)))
b    = h %*% a %*% h             # Determine the inner product matrix
e    = eigen(b)
g1   = cbind(e$vectors[, 1], -e$vectors[, 2])
g2   = diag(e$values[1:2])
xx1  = g1 %*% (g2^0.5)           # Determine the coordinate matrix
x    = cos(pi/2)
y    = sin(pi/2)
z    = -sin(pi/2)
r1   = c(x, z)
r2   = c(y, x)
r    = rbind(r1, r2)
xx2  = xx1 %*% r

xx   = cbind((xx2[, 1] * (-1)) + 500, xx2[, 2] + 500)

# Plot: Map of German Cities
plot(xx[, 1], xx[, 2], xlim = c(0, 900), ylim = c(0, 900), xlab = "EAST - WEST - DIRECTION in km", 
    ylab = "NORTH - SOUTH - DIRECTION in km", main = "Map of German Cities", cex.axis = 1.2, 
    cex.lab = 1.2, cex.main = 1.8)
text(xx[, 1], xx[, 2], labels = c("Berlin", "Dresden", "Hamburg", "Koblenz", "Muenchen", 
    "Rostock"), pos = 4, col = "blue") 
