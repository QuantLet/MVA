
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# parameter settings
z1 = c(0, 2, 3, 2)
z2 = c(3, 2, 2, 1)

# Plot
plot(z1, type = "l", ylim = c(0, 3), xlim = c(1, 4), xlab = "Coordinate", lwd = 2, 
    ylab = "Coordinate Value", frame = TRUE, axes = FALSE)
lines(z2, lwd = 2)
axis(side = 1, at = seq(1, 4), labels = seq(1, 4))
axis(side = 2, at = seq(0, 3), labels = seq(0, 3))
title("Parallel Coordinates Plot") 
