
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

x   = c(2, 3, 4, 2.8, 3)        # Define group 1
xx  = c(1.5, 2, 1.5, 2, 2.2)    # Define group 2

# plot
plot(x, type = "l", col = "red", lwd = 2, xlim = c(1, 5), ylim = c(1, 5), xlab = "Treatment", 
    ylab = "Mean", main = "Population Profiles", cex.lab = 1.2, cex.axis = 1.2, cex.main = 1.8)
lines(xx, col = "blue", lwd = 2, lty = 2)
legend(4.1, 5.1, legend = c("Group 1", "Group 2"), lty = c(1, 2), lwd = c(2, 2), 
    col = c("red", "blue"))
