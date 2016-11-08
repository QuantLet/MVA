
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAdrugsim** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVAdrugsim

Published in : Applied Multivariate Statistical Analysis

Description : 'Produces a contingency table for the drug consumption data from Everitt and Dunn and
calculates Jaccard, simple matching and Tanimoto proximity measures for cluster analysis.'

Keywords : cluster-analysis, proximity, contingency-table, similarity, distance

See also : MVAcarsim, SMScarsim, MMSTATassociation, MVAdrug, MMSTAThelper_function, MVAclususcrime

Author : Awdesch Melzer, Simon Trimborn

Submitted : Wed, October 01 2014 by Awdesch Melzer

Output : 'A three way contingency table: top table for men and bottom table for women.'

```


### R Code:
```r

# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("simba")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# Specifics of the dataset
Q = 3  		# number of variables
I = 2  		# sex: M - F
J = 2  		# drug: Yes - No
K = 5  		# age category: 16-29, 30-44, 45-64, 65-74, 75++

# Truncated dataset with first observations missing
zi = rbind(c(1, 0, 1, 0, 1, 0, 0, 0, 0, 21), c(1, 0, 1, 0, 0, 1, 0, 0, 0, 32), c(1, 
    0, 1, 0, 0, 0, 1, 0, 0, 70), c(1, 0, 1, 0, 0, 0, 0, 1, 0, 43), c(1, 0, 1, 0, 
    0, 0, 0, 0, 1, 19), c(1, 0, 0, 1, 1, 0, 0, 0, 0, 683), c(1, 0, 0, 1, 0, 1, 0, 
    0, 0, 596), c(1, 0, 0, 1, 0, 0, 1, 0, 0, 705), c(1, 0, 0, 1, 0, 0, 0, 1, 0, 295), 
    c(1, 0, 0, 1, 0, 0, 0, 0, 1, 99), c(0, 1, 1, 0, 1, 0, 0, 0, 0, 46), c(0, 1, 1, 
    0, 0, 1, 0, 0, 0, 89), c(0, 1, 1, 0, 0, 0, 1, 0, 0, 169), c(0, 1, 1, 0, 0, 
    0, 0, 1, 0, 98), c(0, 1, 1, 0, 0, 0, 0, 0, 1, 51), c(0, 1, 0, 1, 1, 0, 0, 
    0, 0, 738), c(0, 1, 0, 1, 0, 1, 0, 0, 0, 700), c(0, 1, 0, 1, 0, 0, 1, 0, 
    0, 847), c(0, 1, 0, 1, 0, 0, 0, 1, 0, 336), c(0, 1, 0, 1, 0, 0, 0, 0, 1, 196))

# Read the relevant data
men 	= cbind(zi[1:5, 10], zi[6:10, 10])
women 	= cbind(zi[11:15, 10], zi[16:20, 10])

# create data table
a 	= c(men[, 1], men[, 2], women[, 1], women[, 2])
age 	= rep(c("A1", "A2", "A3", "A4", "A5"), 4)
drug 	= rep(c("DY", "DY", "DY", "DY", "DY", "DN", "DN", "DN", "DN", "DN"), 2)
gender 	= c(rep("men", 10), rep("women", 10))
xtabs(a ~ drug + age + gender)

# prepare data for proximity estimation
xi 	= zi[, 1:9]
xy 	= zi[, 10]
colnames(xi) = c("men", "women", "yes", "no", "16-29", "30-44", "45-64", "65-74", 
    "75++")

y 	= list()
for (i in 1:20) {
    y[[i]] = matrix(rep(xi[i, ], xy[i]), ncol = 9, nrow = xy[i], byrow = T)
}

yy 	= y[[1]]
for (i in 1:20) {
    yy 	= rbind(yy, y[[i]])
}
colnames(yy) = colnames(xi)

# estimate proximity
jaccard = sim((yy), method = "jaccard") 	 	# jaccard
simplem = sim((yy), method = "simplematching")  	# simple matching
tanimot = sim((yy), method = "roger")  			# tanimoto

```
