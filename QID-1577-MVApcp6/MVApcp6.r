
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# load data
x = read.table("carc.txt")
frame = data.frame(x[, 5:7])
colnames(frame) = c("headroom", "rear seat", "trunk space")

m1 = mean(frame[, 1])
m2 = mean(frame[, 2])
m3 = mean(frame[, 3])

# Plot
boxplot(frame, lwd = 1)
title("Boxplot (Car Data)")
lines(c(0.6, 1.4), c(m1, m1), lty = "dotted", lwd = 1.5, col = "red3")
lines(c(1.6, 2.4), c(m2, m2), lty = "dotted", lwd = 1.5, col = "red3")
lines(c(2.6, 3.4), c(m3, m3), lty = "dotted", lwd = 1.5, col = "red3") 
