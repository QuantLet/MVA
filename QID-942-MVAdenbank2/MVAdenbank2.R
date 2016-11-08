
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# Observation: Density estimates are different because R uses a 'gaussian' kernel as default, whereas Xplore uses a Quartic Kernel.

# load data
x = read.table("bank2.dat")

x4 = x[1:100, 4]
x5 = x[1:100, 5]

f4 = density(x4)
f5 = density(x5)

# plot
par(mfrow = c(1, 2))
plot(f4, type = "l", lwd = 3, xlab = "Lower Inner Frame (X4)", ylab = "Density", main = "Swiss bank notes", 
    cex.lab = 1.2, cex.axis = 1.2, cex.main = 1.8)
plot(f5, type = "l", lwd = 3, xlab = "Upper Inner Frame (X5)", ylab = "Density", main = "Swiss bank notes", 
    cex.lab = 1.2, cex.axis = 1.2, cex.main = 1.8)
	