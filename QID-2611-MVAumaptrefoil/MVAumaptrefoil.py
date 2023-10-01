# works on pandas 1.5.3, numpy 1.24.3, matplotlib 3.6.2 and umap-learn 0.5.3
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import umap

def trefoil_knot(t):
    x = np.sin(t) + 2 * np.sin(2 * t) + 0.1 * np.random.randn(1000)
    y = np.cos(t) - 2 * np.cos(2 * t) + 0.1 * np.random.randn(1000)
    z = 5 * (-np.sin(3 * t) + 0.1 * np.random.randn(1000))
    return x, y, z

t = np.linspace(0, 2.0 * np.pi, 1000)
x, y, z = trefoil_knot(t)

fig = plt.figure(figsize=(8, 6))
ax = fig.add_subplot(111, projection="3d")

ax.scatter(x,y,z, c = t, cmap = 'hsv')
ax.view_init(azim=-85, elev=12)
ax.set_title("trefoil knot", y = 0.93)
plt.show()

X = pd.DataFrame(data= {"x":x.ravel(),"y":y.ravel(),"z":z.ravel()})

reducer = umap.UMAP(n_components=2,
               n_neighbors=15,
               random_state=42)
UMAP_X = reducer.fit_transform(X)

fig = plt.figure(figsize=(8, 6))
plt.scatter(UMAP_X[:,0], UMAP_X[:,1], c=t, cmap = "hsv")
plt.title('UMAP embedding')
plt.show()