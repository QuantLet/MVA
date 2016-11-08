
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAcarsim** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVAcarsim

Published in : Applied Multivariate Statistical Analysis

Description : 'Computes the Jaccard, simple matching and Tanimoto proximity coefficients for binary
car data.'

Keywords : cluster-analysis, proximity, similarity, distance, financial

See also : MVAdrugsim, SMScarsim

Author : Awdesch Melzer

Submitted : Sun, September 07 2014 by Awdesch Melzer

Datafile : carmean2.dat

Example : 'Jaccard, simple matching and Tanimoto proximity coefficients for Renault, Rover and
Toyota car data.'

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

x 	= read.table("carmean2.dat")  		# load data
x 	= as.matrix(x[, 2:9])  			# retrieve Renault, Rover, Toyota
x1719 	= x[c(17:19), ]
x.mu 	= apply(x1719, 2, mean)  		# column means
y 	= matrix(0, nrow(x1719), ncol(x1719))  	# empty matrix

# fill binary matrix: if x(i,k) > x_bar(k): 1, else 0
for (i in 1:nrow(x1719)) {
    for (k in 1:ncol(x1719)) {
        if (x1719[i, k] > x.mu[k]) {
            y[i, k] = 1
        } else {
            y[i, k] = 0
        }
    }
}

# similarity coefficients for binary data
sim(y, method = "jaccard")  		# jaccard
sim(y, method = "simplematching")  	# simple matching
sim(y, method = "roger")  		# tanimoto

```
