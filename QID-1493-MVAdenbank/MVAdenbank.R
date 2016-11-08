
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("KernSmooth")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
x  = read.table("bank2.dat")
x1 = x[1:100, 6]
x2 = x[101:200, 6]

# Compute kernel density estimate
fh1 = bkde(x1, kernel = "biweight")  
fh2 = bkde(x2, kernel = "biweight")  

# plot
plot(fh1, type = "l", lwd = 2, xlab = "Counterfeit                  /                 Genuine", 
    ylab = "Density estimates for diagonals", col = "black", main = "Swiss bank notes", 
    xlim = c(137, 143), ylim = c(0, 0.85)) 
lines(fh2, lty = "dotted", lwd = 2, col = "red3")
