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