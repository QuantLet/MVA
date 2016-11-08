
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# load data
data = read.table("bostonh.dat")

# transform data
xt = data
xt[, 1]  = log(data[, 1])
xt[, 2]  = data[, 2]/10
xt[, 3]  = log(data[, 3])
xt[, 5]  = log(data[, 5])
xt[, 6]  = log(data[, 6])
xt[, 7]  = (data[, 7]^(2.5))/10000
xt[, 8]  = log(data[, 8])
xt[, 9]  = log(data[, 9])
xt[, 10] = log(data[, 10])
xt[, 11] = exp(0.4 * data[, 11])/1000
xt[, 12] = data[, 12]/100
xt[, 13] = sqrt(data[, 13])
xt[, 14] = log(data[, 14])
data = xt[, -4]

colnames(data) = c("X1", "X2", "X3", "X5", "X6", "X7", "X8", "X9", "X10", "X11", "X12", 
    "X13", "X14") # rename variables
da  = scale(data) # standardize variables
dat = cor(da)     # correlation matrix

# Maximum Likelihood Factor Analysis without varimax rotation factanal performs
mlm  = factanal(da, 3, rotation = "none", covmat = dat)
load = mlm$loadings                           # estimated factor loadings
ld   = cbind(load[, 1], load[, 2], load[, 3]) # the estimated factor loadings matrix
com  = diag(ld %*% t(ld))                     # communalities are calculated
psi  = diag(dat) - diag(ld %*% t(ld))         # specific variances are calculated
tbl  = cbind(load[, 1], load[, 2], load[, 3], com, psi)

dev.new()
par(mfcol = c(2, 2))

# plot first factor against second
plot(load[, 1], load[, 2], type = "n", xlab = "x", ylab = "y", main = "Factors21 - theta21", 
    font.main = 1, cex.lab = 1.1, cex.axis = 1.1, cex.main = 1.4, ylim = c(-0.6, 0.6))
text(load[, 1], load[, 2], colnames(data), cex = 1.1)
abline(h = 0, v = 0)

# plot first factor against third
plot(load[, 1], load[, 3], type = "n", xlab = "x", ylab = "y", main = "Factors31 - theta31", 
    font.main = 1, cex.lab = 1.1, cex.axis = 1.1, cex.main = 1.4, ylim = c(-0.4, 0.4))
text(load[, 1], load[, 3], colnames(data), cex = 1.1)
abline(h = 0, v = 0)

# plot second factor against third
plot(load[, 2], load[, 3], type = "n", xlab = "x", ylab = "y", main = "Factors32 - theta32", 
    font.main = 1, cex.lab = 1.1, cex.axis = 1.1, cex.main = 1.4, xlim = c(-0.6, 0.6), 
    ylim = c(-0.4, 0.4))
text(load[, 2], load[, 3], colnames(data), cex = 1.1)
abline(h = 0, v = 0)

# Maximum Likelihood Factor Analysis after varimax rotation
var  = varimax(ld)                            # rotates the factor loadings matrix
load = var$loadings                           # estimated factor loadings after varimax
vl   = cbind(load[, 1], load[, 2], load[, 3])
com  = diag(vl %*% t(vl))                     # communalities are calculated
psi  = diag(dat) - diag(vl %*% t(vl))         # specific variances are calculated
tbl  = cbind(load[, 1], load[, 2], load[, 3], com, psi)

dev.new()
par(mfcol = c(2, 2))

# plot first factor against second
plot(load[, 1], load[, 2], type = "n", xlab = "x", ylab = "y", main = "Factors21 - theta21", 
    font.main = 1, cex.lab = 1.1, cex.axis = 1.1, cex.main = 1.4, xlim = c(-1, 1))
text(load[, 1], load[, 2], colnames(data), cex = 1.1)
abline(h = 0, v = 0)

# plot first factor against third
plot(load[, 1], load[, 3], type = "n", xlab = "x", ylab = "y", main = "Factors31 - theta31", 
    font.main = 1, cex.lab = 1.1, cex.axis = 1.1, cex.main = 1.4, xlim = c(-1, 1))
text(load[, 1], load[, 3], colnames(data), cex = 1.1)
abline(h = 0, v = 0)

# plot second factor against third
plot(load[, 2], load[, 3], type = "n", xlab = "x", ylab = "y", main = "Factors32 - theta32", 
    font.main = 1, cex.lab = 1.1, cex.axis = 1.1, cex.main = 1.4, xlim = c(-1, 1))
text(load[, 2], load[, 3], colnames(data), cex = 1.1)
abline(h = 0, v = 0)

# Principal Component Method after varimax rotation spectral decomposition
e      = eigen(dat)
eigval = e$values[1:3]
eigvec = e$vectors[, 1:3]
E      = matrix(eigval, nrow(dat), ncol = 3, byrow = T)
Q      = sqrt(E) * eigvec                     # the estimated factor loadings matrix
pcm    = varimax(Q)                           # rotates the factor loadings matrix
load   = pcm$loadings                         # estimated factor loadings after varimax
ld     = cbind(load[, 1], load[, 2], load[, 3])
com    = diag(ld %*% t(ld))                   # communalities are calculated
psi    = diag(dat) - diag(ld %*% t(ld))       # specific variances are calculated
tbl    = cbind(load[, 1], load[, 2], load[, 3], com, psi)

dev.new()
par(mfcol = c(2, 2))

# plot first factor against second
plot(load[, 1], load[, 2], type = "n", xlab = "x", ylab = "y", main = "Factors21 - theta21", 
    font.main = 1, cex.lab = 1.1, cex.axis = 1.1, cex.main = 1.4)
text(load[, 1], load[, 2], colnames(data), cex = 1.1)
abline(h = 0, v = 0)

# plot first factor against third
plot(load[, 1], load[, 3], type = "n", xlab = "x", ylab = "y", main = "Factors31 - theta31", 
    font.main = 1, cex.lab = 1.1, cex.axis = 1.1, cex.main = 1.4)
text(load[, 1], load[, 3], colnames(data), cex = 1.1)
abline(h = 0, v = 0)

# plot second factor against third
plot(load[, 2], load[, 3], type = "n", xlab = "x", ylab = "y", main = "Factors32 - theta32", 
    font.main = 1, cex.lab = 1.1, cex.axis = 1.1, cex.main = 1.4)
text(load[, 2], load[, 3], colnames(data), cex = 1.1)
abline(h = 0, v = 0)

# Principal Factor Method after varimax rotation inverse of the correlation matrix
f      = solve(dat)
psiini = diag(1/f[row(f) == col(f)]) # preliminary estimate of psi
psi    = psiini
for (i in 1:10) {
    ee     = eigen(dat - psi)
    eigval = ee$values[1:3]
    eigvec = ee$vectors[, 1:3]
    EE     = matrix(eigval, nrow(dat), ncol = 3, byrow = T)
    QQ     = sqrt(EE) * eigvec
    psiold = psi
    psi    = diag(as.vector(1 - t(colSums(t(QQ * QQ)))))
    i      = i + 1
    z      = psi - psiold
    convergence = z[row(z) == col(z)]
}
pfm  = varimax(QQ)                             # rotates the factor loadings matrix
load = pfm$loadings                            # estimated factor loadings after varimax
ld   = cbind(load[, 1], load[, 2], load[, 3])
com  = diag(ld %*% t(ld))                      # communalities are calculated
psi  = diag(dat) - diag(ld %*% t(ld))          # specific variances are calculated
tbl  = cbind(load[, 1], load[, 2], load[, 3], com, psi)

dev.new()
par(mfcol = c(2, 2))

# plot first factor against second
plot(load[, 1], load[, 2], type = "n", xlab = "x", ylab = "y", main = "Factors21 - theta21", 
    font.main = 1, cex.lab = 1.1, cex.axis = 1.1, cex.main = 1.4)
text(load[, 1], load[, 2], colnames(data), cex = 1.1)
abline(h = 0, v = 0)

# plot first factor against third
plot(load[, 1], load[, 3], type = "n", xlab = "x", ylab = "y", main = "Factors31 - theta31", 
    font.main = 1, cex.lab = 1.1, cex.axis = 1.1, cex.main = 1.4, ylim = c(-1, 1))
text(load[, 1], load[, 3], colnames(data), cex = 1.1)
abline(h = 0, v = 0)

# plot second factor against third
plot(load[, 2], load[, 3], type = "n", xlab = "x", ylab = "y", main = "Factors32 - theta32", 
    font.main = 1, cex.lab = 1.1, cex.axis = 1.1, cex.main = 1.4, ylim = c(-1, 1))
text(load[, 2], load[, 3], colnames(data), cex = 1.1)
abline(h = 0, v = 0)