
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("isotone")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# the reported preference orderings
x = c(1:6)
# the estimated preference orderings according to the additive model (16.1) and the metric solution (Table 16.6) in MVA
y = c(0.84, 2.84, 3.16, 3.34, 5.66, 5.16)
z = cbind(x, y)

# PAV algorithm
gp = gpava(x, y)
a  = gp$z              # the reported preference orderings
b  = gp$x              # the estimated preference orderings after PAV algorithm
gp = cbind(a, b)

# Plot of car rankings
plot(gp, z, type = "n", xlab = "revealed rankings", ylab = "estimated rankings", 
    main = "Car rankings", cex.lab = 1.4, cex.axis = 1.4, cex.main = 1.6)
lines(a, b, lwd = 2)
points(x, y, pch = 19, col = "red")
text(x[1], y[1] - 0.1, "car1", font = 2)
text(x[2], y[2] - 0.1, "car2", font = 2)
text(x[3], y[3] - 0.1, "car3", font = 2)
text(x[4], y[4] - 0.1, "car4", font = 2)
text(x[5], y[5] - 0.1, "car5", font = 2)
text(x[6], y[6] - 0.1, "car6", font = 2) 
