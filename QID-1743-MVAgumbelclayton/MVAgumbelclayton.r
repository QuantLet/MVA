
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("QRM")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# Clayton copula sample
clay = rcopula.clayton(10000, theta = 3, 2)

# Gumbel-Hougaard copula sample
gum = rcopula.gumbel(10000, theta = 3, 2)

# Plot of Clayton copula sample
plot(clay, col = "blue3", ylab = "Y", xlab = "X", main = "Clayton", cex = 0.1)

# Plot of GH copula sample
dev.new()
plot(gum, col = "blue3", ylab = "Y", xlab = "X", main = "Gumbel", cex = 0.1) 
