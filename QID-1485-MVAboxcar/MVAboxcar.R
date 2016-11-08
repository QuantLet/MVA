
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# load data
x = read.table("carc.txt")

# parameter settings
k      = 0
l      = 0
m      = 0
us     = NULL
japan  = NULL
europe = NULL
M      = x[, 2]
C      = x[, 13]

for (i in 1:dim(x)[1]) {
    if (x[i, 13] == 1) {
        k = k + 1
        us[k] = x[i, 2]
    } else if (x[i, 13] == 2) {
        l = l + 1
        japan[l] = x[i, 2]
    } else if (x[i, 13] == 3) {
        m = m + 1
        europe[m] = x[i, 2]
    }
}

m1 = mean(us)
m2 = mean(japan)
m3 = mean(europe)

# plot
boxplot(us, japan, europe, axes = FALSE, frame = TRUE)
axis(side = 1, at = seq(1, 3), label = c("US", "JAPAN", "EU"))
axis(side = 2, at = seq(0, 50, 5), label = seq(0, 50, 5))
title("Car Data")
lines(c(0.6, 1.4), c(m1, m1), lty = "dotted", lwd = 1.2)
lines(c(1.6, 2.4), c(m2, m2), lty = "dotted", lwd = 1.2)
lines(c(2.6, 3.4), c(m3, m3), lty = "dotted", lwd = 1.2)

(five = quantile(x[, 2], c(0.025, 0.25, 0.5, 0.75, 0.975)))