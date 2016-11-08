
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("KernSmooth", "misc3d")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
xx = read.table("bank2.dat")

d  = kde3d(xx[, 4], xx[, 5], xx[, 6], n = 15)

# plot
contour3d(d$d, level = c(max(d$d[10, 10, ]) * 0.02, max(d$d[10, 10, ]) * 0.5, max(d$d[10, 
    10, ]) * 1.3), fill = c(FALSE, FALSE, TRUE), col.mesh = c("green", "red", "blue"), 
    engine = "standard", screen = list(z = 210, x = -40, y = -295), scale = TRUE)
title("Swiss bank notes")
