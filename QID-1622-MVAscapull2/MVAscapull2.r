
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# load data
x = read.table("pullover.dat")

# plot
plot(x[, 4], x[, 1], xlab = "Sales Assistants (X4)", ylab = "Sales (X1)", xlim = c(70, 
    120), ylim = c(80, 240), frame = TRUE, axes = FALSE)
title("Pullovers Data")
axis(side = 2, seq(80, 240, 40), seq(80, 240, 40))
axis(side = 1, seq(70, 130, 10), seq(70, 130, 10))
