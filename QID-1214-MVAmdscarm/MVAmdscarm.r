
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# load data
cardat = read.table("carmean2.dat")
car    = cardat[, -1]                             # delete the first column (names of the car marks)

# define variable names
colnames(car) = c("economic", "service", "value", "price", "look", "sporty", "security", 
    "easy")                             

# define car marks
rownames(car) = c("audi", "bmw", "citroen", "ferrari", "fiat", "ford", "hyundai", 
    "jaguar", "lada", "mazda", "mercedes", "mitsubishi", "nissan", "opel_corsa", 
    "opel_vectra", "peugeot", "renault", "rover", "toyota", "trabant", "vw_golf", 
    "vw_passat", "wartburg")            

dist  = dist(car, method = "euclidean", p = 2)      # euclidean distance matrix
dist2 = dist^2                                      # squared euclidean distance matrix
dista = as.matrix(dist2)                            # distance matrix
d     = as.vector(rowMeans(dista))                  # compute mean for every row of the distance matrix
B     = 0.5 * (t(dista - d) - d + mean(d))          # inner product matrix

# spectral decomposition
eig   = eigen(B)
eva   = eig$values
eve   = eig$vectors[, 1:2]
sq    = matrix(sqrt(eva[1:2]), NROW(eva), NCOL(eve), byrow = T)

# the coordinate matrix which contains the point configuration
q     = eve * sq
corr  = cor(cbind(q, car))
r     = matrix(corr, nrow(corr), ncol(corr))

# extract the first two principal components
r     = r[3:ncol(r), 1:2]

# Plot for the MDS solution on the car data
dev.new()
plot(q, type = "n", xlab = "x", ylab = "y", main = "Metric MDS", cex.lab = 1.6, cex.axis = 1.6, 
    cex.main = 1.8)
text(q, rownames(car), cex = 1.2, font = 2)

# Plot for the correlation between the MDS direction and the variables
dev.new()
ucircle = cbind(cos((0:360)/180 * pi), sin((0:360)/180 * pi))
plot(ucircle, type = "l", lty = "solid", main = "Correlations MDS/Variables", xlab = "x", 
    ylab = "y", cex.lab = 1.6, cex.axis = 1.6, cex.main = 1.8, lwd = 2)
text(r, colnames(car), cex = 1.2, font = 2) 
