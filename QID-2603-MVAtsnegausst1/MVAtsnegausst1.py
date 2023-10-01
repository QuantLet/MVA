#works on numpy 1.24.3, matplotlib 3.6.2 and scipy 1.10.1
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import t, norm

xx = np.arange(0, 6.1, 0.1)

fig, ax = plt.subplots(1,1,figsize=(10,10))

ax.plot(xx, norm.pdf(xx), 'blue', lw=3, label='Gaussian')
ax.plot(xx, t.pdf(xx, 1), 'red', lw=3, label='t(1)')

ax.set_xlim([0, 6])
ax.set_ylim([0, 0.42])
ax.set_xlabel('x', fontsize=20)
ax.set_ylabel('f(x)', fontsize=20)
ax.set_title('Gaussian tail and t(1) tail', fontsize=20)
ax.legend(loc='upper right', fontsize=16)

plt.show()