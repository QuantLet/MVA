
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

#load data
blue.data = read.table("pullover.dat", header = T)
attach(blue.data)

# generating mu and S
mu  = colMeans(blue.data)
mu  = t(mu)
(mu = t(mu))
s.unbiased = cov(blue.data)  # the result of cov(xy) is the unbiased one
 
# meaning n/n-1*S
(covxy = s.unbiased/(10/9))

# partial correlation between 'Sales' and 'Price' given 'Advertisement' and 'Sales Assistans', x1 = Sales, x2 = Price
z      = blue.data[c(3:4)]
data   = data.frame(blue.data[, 1], blue.data[, 2], z)
xdata  = na.omit(data.frame(data[, c(1, 2)]))
Sxx    = cov(xdata, xdata)
xzdata = na.omit(data)
xdata  = data.frame(xzdata[, c(1, 2)])
zdata  = data.frame(xzdata[, -c(1, 2)])
Sxz    = cov(xdata, zdata)
zdata  = na.omit(data.frame(data[, -c(1, 2)]))
Szz    = cov(zdata, zdata)
Sxx.z  = Sxx - Sxz %*% solve(Szz) %*% t(Sxz)
(rxx.z = cov2cor(Sxx.z)[1, 2])

# correlation matrix
(P.blue.data = cor(blue.data))
