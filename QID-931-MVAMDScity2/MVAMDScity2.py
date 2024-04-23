# works on numpy 1.25.2 and matplotlib 3.8.0
import numpy as np
import matplotlib.pyplot as plt

ber  = [0, 214, 279, 610, 596, 237]
dre  = [214, 0, 492, 533, 496, 444]
ham  = [279, 492, 0, 520, 772, 140]
kob  = [610, 533, 520, 0, 521, 687]
mue  = [596, 496, 772, 521, 0, 771]
ros  = [237, 444, 140, 687, 771, 0]

dist = np.array([ber, dre, ham, kob, mue, ros])

a = (dist**2) * (-0.5)
i = np.diag([1]*6)
u = [1]*6
u = np.reshape(u, (6, 1))
h = i - (1/6 * (u @ u.T))
b = h @ a @ h
e = np.linalg.eig(b)
xx1 = e[1] @ (np.diag(e[0])**0.5)
xx1 = xx1[:,0:2]

x = np.cos(np.pi/2)
y = np.sin(np.pi/2)
z = -np.sin(np.pi/2)
r = np.array([[x,z],
             [y,x]])
xx2 = np.dot(xx1, r)
xx2[:,0] = xx2[:,0] + 500
xx2[:,1] = xx2[:,1] + 500

cities = ["Berlin", "Dresden", "Hamburg", "Koblenz", "Muenchen", "Rostock"]

fig, ax = plt.subplots(figsize = (7, 7))
ax.scatter(xx2[:, 0], xx2[:, 1], c = "w", edgecolor = "k")
for i in range(len(cities)):
    ax.text(xx2[i, 0], xx2[i, 1], cities[i], c = "b", fontsize = 13)

ax.set_xlim(0, 800)
ax.set_ylim(0, 900)

ax.set_ylabel("NORTH - SOUTH - DIRECTION in km")
ax.set_xlabel("EAST - WEST - DIRECTION in km")

plt.title("Map of German Cities", fontsize = 18)

plt.show()