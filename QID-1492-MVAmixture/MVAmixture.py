# works on numpy 1.23.5, scipy 1.10.0 and matplotlib 3.6.2
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm

xx = np.arange(-6, 6, 0.1)
pdfm = (1/(5* (2*np.pi)**0.5))* (4* np.exp(-xx**2/2) + (1/3)*np.exp(-xx**2/18))

fig1, ax1 = plt.subplots(1,1,figsize=(10, 10))

ax1.plot(xx, pdfm, 'b-', linewidth=3, label='mixture')
ax1.plot(xx, norm.pdf(xx), 'r-', linewidth=3, label='gaussian')
ax1.set_xlabel('X', fontsize=16)
ax1.set_ylabel('Y', fontsize=16)
ax1.set_title('PDF of a Gaussian mixture and distribution', fontsize=23)
fig1.legend(fontsize=18, loc =(0.77, 0.45))

plt.tight_layout()
plt.show()

cdfm = 0.8 * norm.cdf(xx, scale = 0.1) + 0.2 * norm.cdf(xx, scale = 0.9)

fig2, ax2 = plt.subplots(1,1,figsize=(10, 10))

ax2.plot(xx, cdfm, 'b-', linewidth=3, label='mixture')
ax2.plot(xx, norm.cdf(xx), 'r-', linewidth=3, label='gaussian')
ax2.set_xlabel('X', fontsize=16)
ax2.set_ylabel('Y', fontsize=16)
ax2.set_title('CDF of a Gaussian mixture and distribution', fontsize=23)
fig2.legend(fontsize=18, loc =(0.77, 0.45))

plt.tight_layout()
plt.show()