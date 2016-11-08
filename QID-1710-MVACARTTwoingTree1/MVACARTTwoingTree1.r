
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("rpart", "rpartScore")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
x = read.table("bankruptcy.dat")
xx = data.frame(x)

# set the controls
my.control = rpart.control(minsplit = 1, usesurrogate = 2, minbucket = 1, maxdepth = 30, 
    surrogatestyle = 1, cp = 0)

# create classification tree with twoing rule
t2 = rpartScore(V3 ~ V1 + V2, xx, split = "abs", prune = "mr", control = my.control)

# plot classification tree
plot(t2)
text(t2, cex = 0.5) 
title(paste("Classification Tree ")) 
