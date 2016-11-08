
# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# Specifics of the dataset
Q = 3  # number of variables
I = 2  # sex M - F
J = 2  # drug Yes - No
K = 5  # age category 16-29, 30-44, 45-64, 65-74, 75++

# Truncated dataset with first observations missing
zi = rbind(c(1, 0, 1, 0, 1, 0, 0, 0, 0, 21), c(1, 0, 1, 0, 0, 1, 0, 0, 0, 32), c(1, 
    0, 1, 0, 0, 0, 1, 0, 0, 70), c(1, 0, 1, 0, 0, 0, 0, 1, 0, 43), c(1, 0, 1, 0, 
    0, 0, 0, 0, 1, 19), c(1, 0, 0, 1, 1, 0, 0, 0, 0, 683), c(1, 0, 0, 1, 0, 1, 0, 
    0, 0, 596), c(1, 0, 0, 1, 0, 0, 1, 0, 0, 705), c(1, 0, 0, 1, 0, 0, 0, 1, 0, 295), 
    c(1, 0, 0, 1, 0, 0, 0, 0, 1, 99), c(0, 1, 1, 0, 1, 0, 0, 0, 0, 46), c(0, 1, 1, 
        0, 0, 1, 0, 0, 0, 89), c(0, 1, 1, 0, 0, 0, 1, 0, 0, 169), c(0, 1, 1, 0, 0, 
        0, 0, 1, 0, 98), c(0, 1, 1, 0, 0, 0, 0, 0, 1, 51), c(0, 1, 0, 1, 1, 0, 0, 
        0, 0, 738), c(0, 1, 0, 1, 0, 1, 0, 0, 0, 700), c(0, 1, 0, 1, 0, 0, 1, 0, 
        0, 847), c(0, 1, 0, 1, 0, 0, 0, 1, 0, 336), c(0, 1, 0, 1, 0, 0, 0, 0, 1, 
        196))
# namind = c('my1','my2','my3','my4','my5','mn1','mn2','mn3','mn4','mn5','fy1','fy2','fy3','fy4','fy5','fn1','fn2','fn3','fn4','fn5')
# name of columns namvar = ('M','F','DY','DN','A1','A2','A3','A4','A5') 

# Read the relevant data
men     = cbind(zi[1:5, 10], zi[6:10, 10])
women   = cbind(zi[11:15, 10], zi[16:20, 10])
a       = c(men[, 1], men[, 2], women[, 1], women[, 2])
age     = rep(c("A1", "A2", "A3", "A4", "A5"), 4)
drug    = rep(c("DY", "DY", "DY", "DY", "DY", "DN", "DN", "DN", "DN", "DN"), 2)
gender  = c(rep("men", 10), rep("women", 10))
xtabs(a ~ drug + age + gender)
