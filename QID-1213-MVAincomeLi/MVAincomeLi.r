
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
allbus7 = allbus[, c(3, 8)]

# exclude unvalid observations
allbus7       = allbus7[(allbus7$NETTOEIN < 99997) & (allbus7$WOHNFLAE < 998), ]
living_space  = allbus7[, 2]
netincome     = allbus7[, 1]

# hexagon plot
hexbinplot(living_space ~ netincome, main="Hexagon plot", xlab = "Income", ylab = "Flat Size", style = "colorscale", 
    border = TRUE, aspect = 1, trans = sqrt, inv = function(netincome) netincome^2)
