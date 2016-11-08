
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("mvpart")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
x  = read.table("bankruptcy.dat")
xx = data.frame(x)

# set constraint: # of observations per node = 10
my.control = rpart.control(minsplit = 10, usesurrogate = 1, minbucket = 1, maxdepth = 30, 
    surrogatestyle = 1, cp = 0)

# create classification tree
t2 = rpart(V3 ~ V1 + V2, xx, parms = "gini", x = TRUE, y = TRUE, control = my.control)

# plot classification tree
plot(t2)
text(t2, cex = 0.5)
title(paste("Classification Tree ")) 
