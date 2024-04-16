# works on numpy 1.23.5, matplotlib 3.6.2 and scipy 1.10.0
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import genhyperbolic

xx = np.arange(4, 5.1, 0.1)

fig, ax = plt.subplots(1,1,figsize=(10,10))

gh1_pdf = genhyperbolic.pdf(xx, 0.5, 1, 0, 0, 1)
gh2_pdf = genhyperbolic.pdf(xx, 1.5, 1, 0, 0, 1)
nig_pdf = genhyperbolic.pdf(xx, -0.5, 1, 0, 0, 1)
hyp_pdf = genhyperbolic.pdf(xx, 1, 1, 0, 0, 1)

ax.plot(xx, gh1_pdf, 'blue', lw=3, label='GH(f=0.5)')
ax.plot(xx, gh2_pdf, 'black', lw=3, label='GH(f=1.5)')
ax.plot(xx, nig_pdf, 'purple', lw=3, label='NIG')
ax.plot(xx, hyp_pdf, 'red', lw=3, label='HYP')

ax.set_xlim([4, 5])
ax.set_ylim([0, 0.02])
ax.set_xlabel('X', fontsize=20)
ax.set_ylabel('Y', fontsize=20)
ax.set_title('Tail comparison - GH', fontsize=20)
ax.legend(loc='upper right', fontsize=16)

plt.show()