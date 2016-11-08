
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# load data
load("uscrime.rda")
X = uscrime[, 3:9]

row.s    = apply(X, 1, sum)        # row sums
column.s = apply(X, 2, sum)        # column sums
mat.s    = sum(X)                  # matrix sum
D        = matrix(0, nrow = 50, ncol = 50)

# distance for rows
for (i in 1:(dim(X)[1] - 1)) {
    for (j in (i + 1):dim(X)[1]) {
        for (z in 1:dim(X)[2]) {
            D[i, j] = 1/(column.s[z]/mat.s) * ((X[i, z]/row.s[i]) - (X[j, z]/row.s[j]))^2
        }
    }
}
D 
