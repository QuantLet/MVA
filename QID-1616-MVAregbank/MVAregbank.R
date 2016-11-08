
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# load data
x  = read.table("bank2.dat")
X4 = x[1:100, 4]
X5 = x[1:100, 5]

b = lm(X5 ~ X4)$coefficients  # regression of (X5) on (X4) price
Y = b[1] + b[2] * X4  # regression line

# plot
plot(X4, X5, xlab = "Lower inner frame (X4), genuine", ylab = "Upper inner frame (X5), genuine", 
    xlim = c(7, 10.5), ylim = c(7.5, 12), frame = TRUE, axes = FALSE)
lines(X4, Y, col = "red3", lwd = 2)
axis(side = 2, seq(7.5, 12.5, 1), seq(7.5, 12.5, 1))
axis(side = 1, seq(7, 12, 1), seq(7, 12, 1))
title("Swiss bank notes")

