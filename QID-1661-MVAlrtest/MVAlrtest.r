
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# load data
x   = read.table("pullover.dat")  

y   = x[, 1]                                                 # first column (sales)
n   = length(y)                                              # number of observations
x   = cbind(rep(1, length(x[, 1])), x[, 2], x[, 3], x[, 4])  # ones, second to fourth column
p   = dim(x)[2]                                              # number of parameters in beta
(b  = solve(t(x) %*% x) %*% t(x) %*% y)                      # MLE (LSE)

aa  = c(0, 1, 0.5, 0)                                        # matrix A
a   = 0                                                      # constant a
q   = length(a)                                              # number of parameters in constr. beta
(bc = b - solve(t(x) %*% x) %*% aa %*% solve(t(aa) %*% solve(t(x) %*% x) %*% aa) %*% 
    (t(aa) %*% b - a))                                       # constrained MLE

lrt1 = t(y - x %*% bc) %*% (y - x %*% bc)
lrt2 = t(y - x %*% b) %*% (y - x %*% b)
(lrt = n * log(lrt1/lrt2))                                  # LR test statistic

pchisq(lrt, q)                                              # prob to reject hypothesis        

ft1  = (aa %*% b - a) %*% solve(t(aa) %*% solve(t(x) %*% x) %*% aa) %*% t(aa %*% b - 
    a)
ft2  = lrt2
(ft   = ((n - p)/q) * ft1/ft2)                              # F test statistic                    
pf(ft, q, n - p)                                            # prob to reject hypothesis                          
