
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# load data
x  = read.table("cities.txt")
m1 = mean(as.matrix(x))

# Plot box plot
boxplot(x, xlab = "World Cities", ylab = "Values")
lines(c(0.8, 1.2), c(m1, m1), col = "black", lty = "dotted", lwd = 1.2)
title("Boxplot")

# Five Number Summary R 'quantile' function uses a different algorithm to
# calculate the sample quantiles than in the MVA book Therefore, the values
# using Matlab could differ from the Book values, but the difference is not
# great, and should not be significant.  Easiest way to calculate Five Number
# Summary is quantile(population,[.025 .25 .50 .75 .975])
five = quantile(x[, 1], c(0.025, 0.25, 0.5, 0.75, 0.975))

# Display results
print("Five number summary, in millions")
print(five/100)