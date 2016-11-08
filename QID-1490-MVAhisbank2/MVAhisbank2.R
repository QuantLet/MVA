
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# load data
x = read.table("bank2.dat")
x = x[101:200, 6]

origin1 = 137.65
origin2 = 137.75
origin3 = 137.85
origin4 = 137.95

y1 = seq(origin1, 141.05, 0.4)
y2 = seq(origin2, 141.05, 0.4)
y3 = seq(origin3 - 0.4, 141.05, 0.4)  # origin>min(x)
y4 = seq(origin4 - 0.4, 141.05, 0.4)  # origin>min(x)

par(mfrow = c(2, 2))
hist(x, y1, ylab = "Diagonal", xlab = "x_0 = 137.65", xlim = c(137.5, 141), ylim = c(0, 
    42), main = "Swiss Bank Notes", axes = FALSE)
axis(side = 1, at = seq(138, 141), labels = seq(138, 141))
axis(side = 2, at = seq(0, 40, 20), labels = seq(0, 40, 20))

hist(x, y3, ylab = "Diagonal", xlab = "x_0 = 137.85", xlim = c(137.5, 141), ylim = c(0, 
    42), main = "Swiss Bank Notes", axes = FALSE)
axis(side = 1, at = seq(138, 141), labels = seq(138, 141))
axis(side = 2, at = seq(0, 40, 20), labels = seq(0, 40, 20))

hist(x, y2, ylab = "Diagonal", xlab = "x_0 = 137.75", xlim = c(137.5, 141), ylim = c(0, 
    42), main = "Swiss Bank Notes", axes = FALSE)
axis(side = 1, at = seq(138, 141), labels = seq(138, 141))
axis(side = 2, at = seq(0, 40, 20), labels = seq(0, 40, 20))

hist(x, y4, ylab = "Diagonal", xlab = "x_0 = 137.95", xlim = c(137.5, 141), ylim = c(0, 
    42), main = "Swiss Bank Notes", axes = FALSE)
axis(side = 1, at = seq(138, 141), labels = seq(138, 141))
axis(side = 2, at = seq(0, 40, 20), labels = seq(0, 40, 20))