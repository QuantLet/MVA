
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# reads the bank data
x = read.table("bank2.dat")

xg  = x[1:100, ]                # Group first 100 observations    
xf  = x[101:200, ]              # Group second 100 observations
mg  = colMeans(xg)              # Determine the mean for the seperate groups and overall sample
mf  = colMeans(xf)
m   = (mg + mf)/2
w   = 100 * (cov(xg) + cov(xf)) # matrix w for within sum-of-squares
d   = mg - mf                   # Difference in means
a   = solve(w) %*% d            # Determine the factors for linear combinations

yg = as.matrix(xg - matrix(m, nrow = 100, ncol = 6, byrow = T)) %*% a  # Discriminant rule for genuine notes
yf = as.matrix(xf - matrix(m, nrow = 100, ncol = 6, byrow = T)) %*% a  # Discriminant rule for forged notes

xgtest = yg
sg = sum(xgtest < 0)            # Number of misclassified genuine notes

xftest = yf                     # Number of misclassified forged notes
sf = sum(xftest > 0)

fg = density(yg)                # density of projection of genuine notes
ff = density(yf)                # density of projection of forged notes

# plot
plot(ff, lwd = 3, col = "red", xlab = "", ylab = "Densities of Projections", main = "Densities of Projections of Swiss bank notes", 
    xlim = c(-0.2, 0.2), cex.lab = 1.2, cex.axis = 1.2, cex.main = 1.8)
lines(fg, lwd = 3, col = "blue", lty = 2)
text(mean(yf), 3.72, "Forged", col = "red")
text(mean(yg), 2.72, "Genuine", col = "blue")
