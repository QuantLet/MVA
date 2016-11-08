
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("lattice")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
x = read.table("carc.txt")

M = x[, 2]
W = x[, 8]
C = x[, 13]

# point definition
D = C
D[x[, 13] == 2] = 1
D[x[, 13] == 1] = 8

# color definition
P = C
P[x[, 13] == 3] = 4
P[x[, 13] == 2] = 2
P[x[, 13] == 1] = 1

leg = c(8, 1, 3)

# plot
xyplot(W ~ M, pch = D, col = P, xlab = "Mileage (X2)", ylab = "Weight (X8)", main = "Car Data")
