# works on numpy 1.23.5, matplotlib 3.6.2 and scipy 1.10.0
import numpy as np
from scipy.stats import t
import matplotlib.pyplot as plt

# PDF of t-distribution
xx = np.arange(-6, 6, 0.1)
pdf3 = t.pdf(xx, df = 3)
pdf6 = t.pdf(xx, df = 6)
pdf30 = t.pdf(xx, df = 30)

fig1, ax1 = plt.subplots(1,1,figsize=(10, 10))

ax1.plot(xx, pdf3, 'k-', linewidth=3, label='df = 3')
ax1.plot(xx, pdf6, 'b-', linewidth=3, label='df = 6')
ax1.plot(xx, pdf30, 'r-', linewidth=3, label='df = 30')
ax1.set_xlabel('X', fontsize=16)
ax1.set_ylabel('Y', fontsize=16)
ax1.set_title('PDF of t-distribution', fontsize=23)
fig1.legend(fontsize=18, loc =(0.79, 0.45))

plt.tight_layout()
plt.show()

# CDF of t-distribution
cdf3 = t.cdf(xx, df = 3)
cdf6 = t.cdf(xx, df = 6)
cdf30 = t.cdf(xx, df = 30)

fig2, ax2 = plt.subplots(1,1,figsize=(10, 10))

ax2.plot(xx, cdf3, 'k-', linewidth=3, label='df = 3')
ax2.plot(xx, cdf6, 'b-', linewidth=3, label='df = 6')
ax2.plot(xx, cdf30, 'r-', linewidth=3, label='df = 30')
ax2.set_xlabel('X', fontsize=16)
ax2.set_ylabel('Y', fontsize=16)
ax2.set_title('CDF of t-distribution', fontsize=23)
fig2.legend(fontsize=18, loc =(0.79, 0.45))

plt.tight_layout()
plt.show()