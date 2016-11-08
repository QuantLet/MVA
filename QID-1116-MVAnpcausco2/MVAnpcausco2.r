
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# Load data
x = read.table("uscomp2.dat")

# Without IBM and General Electric
x = rbind(x[1:37, ], x[39, ], x[41:79, ])

colnames(x) = c("Company", "A", "S", "MV", "P", "CF", "E", "Sector")
attach(x)
Sector = as.character(Sector)
Sector[1:2]   = "H"
Sector[3:17]  = "E"
Sector[18:34] = "F"
Sector[35:40] = "H"
Sector[41:50] = "M"
Sector[51:61] = "*"
Sector[62:71] = "R"
Sector[72:77] = "*"

x   = x[, 2:7]
n   = nrow(x)
x   = (x - matrix(apply(x, 2, mean), n, 6, byrow = T))/matrix(sqrt((n - 1) * apply(x, 
    2, var)/n), n, 6, byrow = T)  # standardizes the data
eig = eigen((n - 1) * cov(x)/n)   # spectral decomposition
e   = eig$values
v   = eig$vectors
x   = as.matrix(x) %*% v          # principal components
layout(matrix(c(2, 1), 2, 1, byrow = T), c(2, 1), c(2, 1), T)

# plot
plot(e, xlab = "Index", ylab = "Lambda", main = "Eigenvalues of S")
plot(-x[, 1], x[, 2], xlim = c(-2, 8), ylim = c(-8, 8), type = "n", xlab = "PC 1", 
    ylab = "PC 2", main = "First vs. Second PC")
text(-x[, 1], x[, 2], Sector) 
