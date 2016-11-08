
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("hexbin")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
allbus  = read.csv2("allbus.csv")
allbus4 = allbus[, c(2, 6)]

# Exclude unvalid observations
allbus4  = allbus4[(allbus4$ALTER = 100) & (allbus4$COMPUTER < 999), ]
ages4    = allbus4[, 1]
computer = allbus4[, 2]

# Hexagon plot
hexbinplot(computer ~ ages4, main="Hexagon plot", xlab = "Age", ylab = "Computer time", 
           style = "colorscale", aspect = 1, trans = sqrt, inv = function(ages4) ages4 ^ 2)
