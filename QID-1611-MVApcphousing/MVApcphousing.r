
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("MASS")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
x = read.table("bostonh.dat")

z = x[, 14]
z[x[, 14] <= median(x[, 14])] = 1
z[x[, 14] > median(x[, 14])] = 2

parcoord(x[, seq(1, 14, 1)], lty = z, lwd = 0.7, col = z, main = "Parallel Coordinates Plot for Boston Housing", 
    frame = TRUE)
axis(side = 2, at = seq(0, 1, 0.2), labels = seq(0, 1, 0.2)) 
