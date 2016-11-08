
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# Data (eye color vs. hair color, r = number of rows, c = number of columns)
r     = 4
c     = 4
X     = c(68, 119, 26, 7, 15, 54, 14, 10, 5, 29, 14, 16, 20, 84, 17, 94)
X     = matrix(X, nrow = r, ncol = c)
X     = t(X)             # Data matrix
rowst = rowSums(X)       # marginal row
colst = colSums(X)       # marginal column
n     = sum(X)           # sample size

# Expected values under independence
E     = matrix(rep(NA, r * c), nrow = r, ncol = c)
for (i in c(0:(r - 1))) {
    i = i + 1
    for (j in c(0:(c - 1))) {
        j = j + 1
        e = rowst[i] * colst[j]/n
        E[i, j] = e
    }
}
E

# Chi-Square test statistic
(Chi2  = sum(sum((E - X)^2/E)))
