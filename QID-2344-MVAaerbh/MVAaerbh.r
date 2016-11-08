
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# load data
data = read.table("bostonh.dat")

# transform data
xt        = data
xt[, 1]   = log(data[, 1])
xt[, 2]   = data[, 2]/10
xt[, 3]   = log(data[, 3])
xt[, 5]   = log(data[, 5])
xt[, 6]   = log(data[, 6])
xt[, 7]   = (data[, 7]^(2.5))/10000
xt[, 8]   = log(data[, 8])
xt[, 9]   = log(data[, 9])
xt[, 10]  = log(data[, 10])
xt[, 11]  = exp(0.4 * data[, 11])/1000
xt[, 12]  = data[, 12]/100
xt[, 13]  = sqrt(data[, 13])
xt[, 14]  = log(as.numeric(data[, 14]))
data      = xt[, -4]

da    = scale(data)                     # standardize variables
d     = dist(da, "euclidean", p = 2)    # euclidean distance matrix
w     = hclust(d, method = "ward.D")    # cluster analysis with ward algorithm
tree  = cutree(w, 2)                    # define the clusters, tree=1 if cluster=1

# the following two lines under comments are for price of Boston houses 
# tree = (xt[, 14] > median(xt[, 14])) + 1 
# da = da[, 1:12]

n = nrow(data)

# AER for clusters of Boston houses
i     = 0
mis1  = 0
mis2  = 0
corr1 = 0
corr2 = 0
while (i < n) {
    i     = i + 1
    xi    = subset(da, 1:n != i)
    treei = subset(tree, 1:n != i)
    t1    = subset(xi, treei == 1)
    t2    = subset(xi, treei == 2)
    m1    = colMeans(t1)                # mean of first cluster
    m2    = colMeans(t2)                # mean of second cluster
    m     = (m1 + m2)/2                 # mean of both clusters
    s     = ((nrow(t1) - 1) * cov(t1) + (nrow(t2) - 1) * cov(t2))/(nrow(da) - 2)    # common variance matrix
    alpha = solve(s) %*% (m1 - m2)                                                  # alpha for the discrimination rule
    mis1  = mis1 + (tree[i] == 1) * ((da[i, ] - m) %*% alpha < 0)                   # misclassified 1
    mis2  = mis2 + (tree[i] == 2) * ((da[i, ] - m) %*% alpha > 0)                   # misclassified 2
    corr1 = corr1 + (tree[i] == 1) * ((da[i, ] - m) %*% alpha > 0)                  # correct 1
    corr2 = corr2 + (tree[i] == 2) * ((da[i, ] - m) %*% alpha < 0)                  # correct 2
}

aer = (mis1 + mis2)/nrow(da)            # AER (actual error rate)
print(aer) 
