
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

# a, b, h, i are matrices
a    = (dist^2) * (-0.5)
i    = diag(6)
u    = rep(1, 6)
h    = i - (1/6 * (u %*% t(u)))
b    = h %*% a %*% h                       # Determine the inner product matrix
e    = eigen(b)
x    = e$vectors %*% (diag(e$values)^0.5)  # Determine the coordinate matrix

# Plot: Initial Configuration
plot(x[, 1], x[, 2], xlim = c(-500, 700), ylim = c(-500, 300), xlab = "NORTH - SOUTH - DIRECTION in km", 
    ylab = "EAST - WEST - DIRECTION in km", main = "Initial Configuration", cex.axis = 1.2, 
    cex.lab = 1.2, cex.main = 1.8)
text(x[, 1], x[, 2], labels = c("Berlin", "Dresden", "Hamburg", "Koblenz", "Muenchen", 
    "Rostock"), pos = 4, col = "blue") 
