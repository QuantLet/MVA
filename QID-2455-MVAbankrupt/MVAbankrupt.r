
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# read data and set variables
data  = read.table("bankrupt.txt")
length(data)
y     = data[, 6]
x1    = data[, 1]
x2    = data[, 2]
x3    = data[, 3]
x4    = data[, 4]
x5    = data[, 5]

# compute logit model
fit   = glm(y ~ x3 + x4 + x5, family = binomial(link = "logit"))
summary(fit)
