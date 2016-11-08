
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# load data
x = read.table("bank2.dat")
x = x[101:200, 6]
origin = 137.75

# Because origin<min(x), the histogram includes all values
y1 = seq(137.75, 141.05, 0.1)
y2 = seq(137.75, 141.05, 0.2)
y3 = seq(137.75, 141.05, 0.3)
y4 = seq(137.75, 141.05, 0.4)

par(mfrow = c(2, 2))

hist(x, y1, ylab = "Diagonal", xlab = "h = 0.1", xlim = c(137.5, 141), ylim = c(0, 
    10.5), main = "Swiss Bank Notes", axes = FALSE)
axis(side = 1, at = seq(138, 141), labels = seq(138, 141))
axis(side = 2, at = seq(0, 10, 2), labels = seq(0, 10, 2))

hist(x, y3, ylab = "Diagonal", xlab = "h = 0.3", xlim = c(137.5, 141), ylim = c(0, 
    31.5), main = "Swiss Bank Notes", axes = FALSE)
axis(side = 1, at = seq(138, 141), labels = seq(138, 141))
axis(side = 2, at = seq(0, 30, 5), labels = seq(0, 30, 5))

hist(x, y2, ylab = "Diagonal", xlab = "h = 0.2", xlim = c(137.5, 141), ylim = c(0, 
    21), main = "Swiss Bank Notes", axes = FALSE)
axis(side = 1, at = seq(138, 141), labels = seq(138, 141))
axis(side = 2, at = seq(0, 20, 5), labels = seq(0, 20, 5))

hist(x, y4, ylab = "Diagonal", xlab = "h = 0.4", xlim = c(137.5, 141), ylim = c(0, 
    42), main = "Swiss Bank Notes", axes = FALSE)
axis(side = 1, at = seq(138, 141), labels = seq(138, 141))
axis(side = 2, at = seq(0, 40, 10), labels = seq(0, 40, 10))