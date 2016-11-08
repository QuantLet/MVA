
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("lars")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
data = read.table("carc.dat")

y   = data[, 2]
x1  = data[, 3]
x2  = data[, 4]
x3  = data[, 5]
x4  = data[, 6]
x5  = data[, 7]
x6  = data[, 8]
x7  = data[, 9]
x8  = data[, 10]
x9  = data[, 11]
x10 = data[, 12]
x11 = data[, 13]
x12 = data[, 14]

x   = cbind(x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12)
(lasso.regress = lars(x, y, type = "lasso", normalize = TRUE, intercept = TRUE, max.steps = 1000))
summary(lasso.regress)

# plot
plot.lars(lasso.regress, lwd = 3)
