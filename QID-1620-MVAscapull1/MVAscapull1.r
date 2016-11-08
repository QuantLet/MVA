
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# load data
x = read.table("pullover.dat")

# plot
plot(x[, 2], x[, 1], main = "Pullovers Data", ylab = "Sales (X1)", xlab = "Price (X2)", 
    xlim = c(78, 127), ylim = c(80, 240), frame = TRUE, axes = FALSE)
axis(side = 2, seq(80, 240, 40), seq(80, 240, 40))
axis(side = 1, seq(80, 130, 10), seq(80, 130, 10))
