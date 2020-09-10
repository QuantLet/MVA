import pandas as pd
from sklearn.cluster import SpectralClustering
import matplotlib.pyplot as plt

data = pd.read_csv("data_example.dat", sep = "\s+", header=None)
data = data.T

sc = SpectralClustering(n_clusters=4, eigen_solver="arpack", affinity = "rbf").fit(data)

fig, ax = plt.subplots(figsize = (10, 10))
ax.scatter(data[0], data[1], c = "black")
ax.set_title("Raw Data")
plt.show()

fig, ax = plt.subplots(figsize = (10, 10))
ax.scatter(data[0], data[1], c = sc.labels_)
ax.set_title("Derived Clusters")
plt.show()