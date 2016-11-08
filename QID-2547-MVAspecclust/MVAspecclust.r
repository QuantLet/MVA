
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("kernlab")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
data = t(read.table("data_example.dat", quote = ""))
sc = specc(data, centers = 4)
centers(sc)
size(sc)
withinss(sc)

# plot 1: raw data
plot(data, col = "black", main = "Raw Data", xlab = "", ylab = "", cex.axis = 2, lwd = 2, pch = 16)

# plot 2: derived clusters
dev.new("")
plot(data, col = sc, main = "Derived Clusters", xlab = "", ylab = "", cex.axis = 2, lwd = 2, pch = 16) 
