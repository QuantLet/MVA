
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
data = read.table("bank2.dat")
C    = c(rep(1, 100), rep(2, 100))
x    = data

# plot
ir   = rbind(x[, , 1], x[, , 2], x[, , 3], x[, , 4], x[, , 5], x[, , 6])
parcoord(log(ir)[, c(1, 2, 3, 4, 5, 6)], lty = c(rep(1, 5), rep(4, 5)), lwd = 2, col = C, main = "Parallel coordinates plot (Bank data)", 
    frame = TRUE)
axis(side = 2, at = seq(0, 1, 0.2), labels = seq(0, 1, 0.2))
