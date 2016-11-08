
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# create blue and black points
a = c(-sqrt(3), 0, sqrt(3))
blue = rep(-2:2, each = length(a))
b = c(-sqrt(3)/2, sqrt(3)/2, 3 * sqrt(3)/2)

black = rep(-1.5:2.5, each = length(b))
point1 = rep(a, length(blue)/length(a))
point2 = rep(b, length(black)/length(b))
red = c(-0.2, 0.2)

co1 = sqrt(3)/2 - 1/sqrt(3)
co2 = sqrt(3)/2 - 1/(2 * sqrt(3))
co3 = sqrt(3)/2 + 1/(2 * sqrt(3))
co4 = sqrt(3)/2 + 1/sqrt(3)
co5 = -1/sqrt(3)
co6 = -1/(2 * sqrt(3))

# plot
plot(xy.coords(blue, point1), main = "Hexagon Algorithm", col = "blue", xlab = "X", ylab = "Y", xlim = c(-2, 
    2), ylim = c(-2, 3), asp = 1, cex = 0.35)

points(xy.coords(black, point2), col = "black", xlim = c(-2, 2), ylim = c(-3, 3), 
    asp = 1, cex = 0.35)

# create a red point
points(xy.coords(-0.2, 0.2), col = "red", xlim = c(-2, 2), ylim = c(-3, 3), asp = 1, 
    cex = 0.35)

# creat blue rectangle
polygon(c(-1, -1, 0, 0), c(0, sqrt(3), sqrt(3), 0), border = "blue", xlim = c(-2, 
    2), ylim = c(-3, 3), asp = 1, cex = 0.35)

# creat black rectangle
polygon(c(-0.5, -0.5, 0.5, 0.5), c(-sqrt(3)/2, sqrt(3)/2, sqrt(3)/2, -sqrt(3)/2), 
    xlim = c(-2, 2), ylim = c(-3, 3), asp = 1, cex = 0.35)

# creat green hexagon
polygon(c(-0.5, -1, -1, -0.5, 0, 0), c(co1, co2, co3, co4, co3, co2), border = "green", 
    xlim = c(-2, 2), ylim = c(-3, 3), asp = 1, cex = 0.35)

# creat yellow hexagon
polygon(c(0, -0.5, -0.5, 0, 0.5, 0.5), c(co5, co6, co1, co2, co1, co6), border = "yellow", 
    xlim = c(-2, 2), ylim = c(-3, 3), asp = 1, cex = 0.35)
