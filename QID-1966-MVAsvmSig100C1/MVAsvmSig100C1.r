
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("kernlab", "tseries", "quadprog", "zoo")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data and create an SVM classification model of type 'ksvm
G = read.matrix("Bankruptcy100by100noNA.txt", header = TRUE, sep = "")
bankmodel_draw = ksvm(G[, c(7, 28)], G[, c(3)], type = "C-svc", kernel = "rbfdot", 
    kpar = list(sigma = 1/100), C = 1)

# Print output of SVM
print(bankmodel_draw)

# Create plot of SVM classification model
plot(bankmodel_draw, data = G[, c(7, 28)]) 
