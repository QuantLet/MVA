# works on pandas 1.5.3 and numpy 1.24.3
import pandas as pd
import numpy as np

blue_data = pd.read_table("pullover.dat", header=None, delim_whitespace=True)
mu = np.mean(blue_data, axis=0)
mu = np.transpose(mu)
print("mu =", mu)
s_unbiased = np.cov(blue_data, rowvar=False, ddof=1) # unbiased estimate of covariance matrix
covxy = s_unbiased / (10/9) # calculating covariance using the formula n/n-1*S
print("cov_xy =", covxy)

xdata = blue_data.iloc[:, :2]
zdata = blue_data.iloc[:, 2:]
Sxx = np.cov(xdata, rowvar=False)
Sxz = np.cov(xdata, zdata, rowvar=False)[0:2,2:4]
Szz = np.cov(zdata, rowvar=False)
Sxx_z = Sxx - np.dot(Sxz, np.dot(np.linalg.inv(Szz), Sxz.T))
rxx_z = Sxx_z[0, 1]/np.sqrt(Sxx_z[0, 0]*Sxx_z[1, 1]) # calculating correlation using formula r = cov/(std_dev1 * std_dev2)
print("rxx_z =", np.round(rxx_z, 3))

# correlation matrix
P_blue_data = np.corrcoef(blue_data, rowvar=False)
print("P_blue_data =\n",  np.round(P_blue_data, 3))
