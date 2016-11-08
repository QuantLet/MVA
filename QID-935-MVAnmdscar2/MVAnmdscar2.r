
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

x = cbind(c(3, 2, 1, 10), c(2, 7, 3, 4))

d = as.matrix(dist(x))

d1 = c(1, 2, 3, d[1, 2])
d2 = c(1, 3, 2, d[1, 3])
d3 = c(1, 4, 5, d[1, 4])
d4 = c(2, 3, 1, d[2, 3])
d5 = c(2, 4, 4, d[2, 4])
d6 = c(3, 4, 6, d[3, 4])
delta = cbind(d1, d2, d3, d4, d5, d6)

f1 = c(1, d[2, 3])
f2 = c(2, d[1, 3])
f3 = c(3, d[1, 2])
f4 = c(4, d[2, 4])
f5 = c(5, d[1, 4])
f6 = c(6, d[3, 4])
fig = rbind(f1, f2, f3, f4, f5, f6)

# plot
plot(fig, pch = 15, col = "blue", xlim = c(0, 7), ylim = c(0, 10), xlab = "Dissimilarity", 
    ylab = "Distance", main = "Dissimilarities and Distances", cex.axis = 1.2, cex.lab = 1.2, 
    cex.main = 1.8)
lines(fig, lwd = 3)
text(fig, labels = c("(2,3)", "(1,3)", "(1,2)", "(2,4)", "(1,4)", "(3,4)"), pos = 4, 
    col = "red") 
