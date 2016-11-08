
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# load data
x   = read.table("bank2.dat")
x56 = x[, 5:6]
x1  = rep(1, 100)
x2  = rep(2, 100)
xx  = cbind(x56, c(x1, x2))

# plot
plot(xx[, 1], xx[, 2], pch = c(xx[, 3]), col = c(xx[, 3]), frame = TRUE, axes = FALSE, 
    ylab = "", xlab = "", ylim = c(137.5, 142.5), xlim = c(7, 13))
axis(side = 1, at = seq(7, 13, 1), labels = seq(7, 13, 1))
axis(side = 2, at = seq(138, 142, 1), labels = seq(138, 142, 1))
title("Swiss bank notes")
