
# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("grplasso")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

data(splice)

contr = list(Pos.1 = "contr.sum", Pos.2 = "contr.sum", Pos.3 = "contr.sum", Pos.4 = "contr.sum")

lambda = lambdamax(y ~ Pos.1 * Pos.2 * Pos.3 * Pos.4, data = splice, model = LogReg(), 
    contrasts = contr, standardize = TRUE) * 0.8^(0:8)

fit = grplasso(y ~ Pos.1 * Pos.2 * Pos.3 * Pos.4, data = splice, model = LogReg(), 
    lambda = lambda, contrasts = contr, standardize = TRUE, control = grpl.control(trace = 0, 
        inner.loops = 0, update.every = 1, update.hess = "lambda"))

# plot
plot(fit, log = "x", lwd = 3)