# works on numpy 1.23.5, matplotlib 3.6.2 and scipy 1.10.0
import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt

xx = np.arange(-6, 6, 0.01)
nig_pdf = stats.genhyperbolic.pdf(xx, -0.5, 1, 0, 0, 1)
lap_pdf = stats.laplace.pdf(xx)
cau_pdf = stats.cauchy.pdf(xx)
gau_pdf = stats.norm.pdf(xx)

fig1, ax1 = plt.subplots(1,1,figsize=(10, 10))

ax1.plot(xx, lap_pdf, 'black', linestyle=(5, (10, 3)), lw=3, label='Laplace')
ax1.plot(xx, nig_pdf, 'green', lw=3, label='NIG')
ax1.plot(xx, cau_pdf, 'blue', linestyle=':', lw=3, label='Cauchy')
ax1.plot(xx, gau_pdf, 'red', lw=3, label='Gaussian')
ax1.set_xlabel('X', fontsize=16)
ax1.set_ylabel('Y', fontsize=16)
ax1.set_title('Distribution comparison', fontsize=23)
fig1.legend(fontsize=18, loc =(0.76, 0.45))

plt.tight_layout()
plt.show()

fig2, ax2 = plt.subplots(1,1,figsize=(10, 10))

ax2.plot(xx, lap_pdf, 'black', linestyle=(5, (10, 3)), lw=3, label='Laplace')
ax2.plot(xx, nig_pdf, 'green', lw=3, label='NIG')
ax2.plot(xx, cau_pdf, 'blue', linestyle=':', lw=3, label='Cauchy')
ax2.plot(xx, gau_pdf, 'red', lw=3, label='Gaussian')
ax2.set_xlabel('X', fontsize=16)
ax2.set_ylabel('Y', fontsize=16)
ax2.set_title('Tail comparison', fontsize=23)
ax2.set_xlim([-5, -4])
ax2.set_ylim([0, 0.02])
fig2.legend(fontsize=18, loc =(0.76, 0.5))

plt.tight_layout()
plt.show()