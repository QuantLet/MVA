#works on pandas 1.5.2 and numpy 1.23.5
import pandas as pd
import numpy as np

df = pd.read_csv('bostonh.dat', sep='\s+', header=None, names=np.arange(1,15,1))

df2 = pd.DataFrame()
df2[[1,3,5,6,8,9,10,14]] = np.log(df[[1,3,5,6,8,9,10,14]])
df2[4] = df[4]
df2.loc[:,2] = df.loc[:,2]/10
df2.loc[:,7] = (pow(df.loc[:,7],2.5))/10000
df2.loc[:,11] = (np.exp(0.4*df.loc[:,11]))/1000
df2.loc[:,12] = df.loc[:,12]/100
df2.loc[:,13] = pow(df.loc[:,13],0.5)

cols= np.arange(1,15,1)
df2 = df2[cols]

original_data_summary = pd.DataFrame({
    'Mean': df.mean(),
    'Median': df.median(),
    'Variance': df.var(),
    'Standard Deviation': df.std()
})
print(original_data_summary)

transformed_data_summary = pd.DataFrame({
    'Mean': df2.mean(),
    'Median': df2.median(),
    'Variance': df2.var(),
    'Standard Deviation': df2.std()
})
print(transformed_data_summary)

