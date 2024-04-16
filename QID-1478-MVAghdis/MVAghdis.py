# works on numpy 1.23.5, matplotlib 3.6.2 and scipy 1.10.0
import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt

# PDF of Generalised Hyperbolic Distribution
xx = np.arange(-6, 6, 0.1)
gh_pdf = stats.genhyperbolic.pdf(xx, 0.5, 1, 0, 0, 1)
nig_pdf = stats.genhyperbolic.pdf(xx, -0.5, 1, 0, 0, 1)
hyp_pdf = stats.genhyperbolic.pdf(xx, 1, 1, 0, 0, 1)

fig1, ax1 = plt.subplots(1,1,figsize=(10, 10))

ax1.plot(xx, gh_pdf, 'k-', linewidth=3, label='GH')
ax1.plot(xx, nig_pdf, 'b-', linewidth=3, label='NIG')
ax1.plot(xx, hyp_pdf, 'r-', linewidth=3, label='HYP')
ax1.set_xlabel('X', fontsize=16)
ax1.set_ylabel('Y', fontsize=16)
ax1.set_title('PDF of GH, HYP and NIG', fontsize=23)
fig1.legend(fontsize=18, loc =(0.83, 0.45))

plt.tight_layout()
plt.show()

# CDF of Generalised Hyperbolic Distribution
gh_cdf = stats.genhyperbolic.cdf(xx, 0.5, 1, 0, 0, 1)
nig_cdf = stats.genhyperbolic.cdf(xx, -0.5, 1, 0, 0, 1)
hyp_cdf = stats.genhyperbolic.cdf(xx, 1, 1, 0, 0, 1)

fig2, ax2 = plt.subplots(1,1,figsize=(10, 10))

ax2.plot(xx, gh_cdf, 'k-', linewidth=3, label='GH')
ax2.plot(xx, nig_cdf, 'b-', linewidth=3, label='NIG')
ax2.plot(xx, hyp_cdf, 'r-', linewidth=3, label='HYP')
ax2.set_xlabel('X', fontsize=16)
ax2.set_ylabel('Y', fontsize=16)
ax2.set_title('CDF of GH, HYP and NIG', fontsize=23)
fig2.legend(fontsize=18, loc =(0.83, 0.45))

plt.tight_layout()
plt.show()