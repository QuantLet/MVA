[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAdrugsim** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet: MVAdrugsim

Published in: Applied Multivariate Statistical Analysis

Description: Produces a contingency table for the drug consumption data from Everitt and Dunn and calculates Jaccard, simple matching and Tanimoto proximity measures for cluster analysis.

Keywords: cluster-analysis, proximity, contingency-table, similarity, distance

See also: MVAcarsim, SMScarsim, MMSTATassociation, MVAdrug, MMSTAThelper_function, MVAclususcrime

Author: Awdesch Melzer, Simon Trimborn

Author[Python]: 'Matthias Fengler, Liudmila Gorkun-Voevoda'

Submitted: Wed, October 01 2014 by Awdesch Melzer

Submitted[Python]: 'Fri, April 16 2021 by Liudmila Gorkun-Voevoda'

Output: 'A three way contingency table: top table for men and bottom table for women.'

```

### PYTHON Code
```python

import pandas as pd
import numpy as np

Q = 3  		# number of variables
I = 2  		# sex: M - F
J = 2  		# drug: Yes - No
K = 5  		# age category: 16-29, 30-44, 45-64, 65-74, 75++


zi = pd.DataFrame(data = {"0": [1, 0, 1, 0, 1, 0, 0, 0, 0, 21], 
                          "1": [1, 0, 1, 0, 0, 1, 0, 0, 0, 32],
                          "2": [1, 0, 1, 0, 0, 0, 1, 0, 0, 70],
                          "3": [1, 0, 1, 0, 0, 0, 0, 1, 0, 43],
                          "4": [1, 0, 1, 0, 0, 0, 0, 0, 1, 19],
                          "5": [1, 0, 0, 1, 1, 0, 0, 0, 0, 683],
                          "6": [1, 0, 0, 1, 0, 1, 0, 0, 0, 596],
                          "7": [1, 0, 0, 1, 0, 0, 1, 0, 0, 705],
                          "8": [1, 0, 0, 1, 0, 0, 0, 1, 0, 295],
                          "9": [1, 0, 0, 1, 0, 0, 0, 0, 1, 99],
                          "10": [0, 1, 1, 0, 1, 0, 0, 0, 0, 46],
                          "11": [0, 1, 1, 0, 0, 1, 0, 0, 0, 89],
                          "12": [0, 1, 1, 0, 0, 0, 1, 0, 0, 169],
                          "13": [0, 1, 1, 0, 0, 0, 0, 1, 0, 98],
                          "14": [0, 1, 1, 0, 0, 0, 0, 0, 1, 51],
                          "15": [0, 1, 0, 1, 1, 0, 0, 0, 0, 738],
                          "16": [0, 1, 0, 1, 0, 1, 0, 0, 0, 700],
                          "17": [0, 1, 0, 1, 0, 0, 1, 0, 0, 847],
                          "18": [0, 1, 0, 1, 0, 0, 0, 1, 0, 336],
                          "19": [0, 1, 0, 1, 0, 0, 0, 0, 1, 196],}).T



men = np.column_stack((zi.iloc[:5, 9], zi.iloc[5:10, 9]))
women = np.column_stack((zi.iloc[10:15, 9], zi.iloc[15:20, 9]))

a = np.array([men.flatten(order = "F"), women.flatten(order = "F")]).flatten()
age = ["A1", "A2", "A3", "A4", "A5"] * 4
drug = (["DY"] * 5 + ["DN"] * 5) * 2
gender = ["men"] * 10 + ["women"] * 10

data = pd.DataFrame(data = {"a": a, "age": age, "drug": drug, "gender": gender})

print(data[data.gender=="men"].pivot(index='drug', columns='age', values='a'))
print(data[data.gender=="women"].pivot(index='drug', columns='age', values='a'))

xi = zi.iloc[:, :-1]
xy = zi.iloc[:, -1]
    
yy = np.tile(xi.iloc[0,:], (xy[0], 1))
for i in range(0, 20):
    yy = np.append(yy, np.tile(xi.iloc[i,:], (xy[i], 1)), axis = 0)
    

#true positives + true negatives
tptn = (yy[:, None, :] == yy).sum(2)
#true positives
tp = np.logical_and((np.tile((yy[:, None, :] == 1), (1,len(yy),1))), 
                    (yy[:, None, :] == yy)).sum(2)
#true negatives
tn = np.logical_and((np.tile((yy[:, None, :] == 0), (1,len(yy),1))), 
                    (yy[:, None, :] == yy)).sum(2)
#false positives + false negatives
fpfn = (yy[:, None, :] != yy).sum(2)

jaccard = tp/(tp+fpfn)
simplem = (tp+tn)/(tptn+fpfn)
tanimot = (tp+tn)/(tptn+2*(fpfn))
```

automatically created on 2021-12-15

### R Code
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

automatically created on 2021-12-15