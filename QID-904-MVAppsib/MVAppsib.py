# Works on pandas 2.0.0, numpy 1.24.2, scipy 1.11.3, scikit-learn 1.3.1, matplotlib 3.7.1
import pandas as pd
import numpy as np
from numpy.random import normal, uniform
from numpy.linalg import norm as numpy_norm
from scipy.stats import norm as scipy_norm
from sklearn.neighbors import KernelDensity
import matplotlib.pyplot as plt
np.random.seed(10)

def ppsib(px):
    # Ensure px is a numpy array and reshape it to 2D if it's 1D.
    np_px = np.asarray(px).reshape(-1, 1)
    n, m = np_px.shape  # Get the dimensions of the reshaped array.
    
    # Center the data by subtracting column means from the reshaped array.
    cx = np_px - np.mean(np_px, axis=0)
    
    # Calculate central moments up to the fourth for each column from the centered data.
    mu = np.vstack([np.mean(cx, axis=0),  # Mean
                    np.mean(cx**2, axis=0),  # Variance
                    np.mean(cx**3, axis=0),  # Skewness
                    np.mean(cx**4, axis=0)]) # Kurtosis
    
    # Skewness
    k3 = mu[2, :]
    
    # Adjusted kurtosis
    k4 = mu[3, :] - 3 * (mu[1, :]**2)
    
    # Index based on skewness and kurtosis.
    ind = (k3**2 + (k4**2) / 4) / 12
    
    return ind.item()


def ppexample(x, h, n):
    # Create an evaluation grid for density estimation.
    xg = np.arange(-4, 4.1, 0.1).reshape(-1, 1)

    # Generate and normalize a random starting vector.
    p = normal(size=x.shape[1])
    p /= numpy_norm(p)
    
    # Project data onto the starting vector and calculate initial index.
    xp = x@p
    imin = ppsib(xp)
    imax = imin
    
    # Set up 'xi' points for KDE, apply transformations, and estimate density.
    xi = np.column_stack((xp, uniform(0, 1, size=len(xp))))
    xi[:, 1] = -0.11 - 0.08 * xi[:, 1] # Adjust y-values
    kde_xi = KernelDensity(bandwidth=h, kernel='epanechnikov')
    kde_xi.fit(xi[:, 0].reshape(-1, 1))
    log_dens_xi = kde_xi.score_samples(xg)
    fi = np.column_stack((xg.flatten(), np.exp(log_dens_xi)))


    # Set up 'xa' points for KDE, apply transformations, and estimate density.
    xa = np.column_stack((xp, uniform(0, 1, size=len(xp))))
    xa[:, 1] = -0.01 - 0.08 * xa[:, 1] # Adjust y-values
    kde_xa = KernelDensity(bandwidth=h, kernel='epanechnikov')
    kde_xa.fit(xa[:, 0].reshape(-1, 1))
    log_dens_xa = kde_xa.score_samples(xg)
    fa = np.column_stack((xg.flatten(), np.exp(log_dens_xa)))

    # Search for better projection vector
    i = 0
    pmin = 1
    pmax = 1
    inds = [1/np.sqrt(4 * np.pi), imax]
    pind = np.column_stack((np.arange(1, len(inds) + 1), inds)) 
    mini = None 

    while i < n:
        i += 1
        p = normal(size=x.shape[1])
        p /= numpy_norm(p)
        xp = x@p
        ind = ppsib(xp)
        inds.append(ind)
        pind = np.column_stack((np.arange(1, len(inds) + 1), inds))
        cind = np.array([2] + [1] * (len(inds) - 1))
        cind[np.argmax(inds)] = 4
        cind[np.argmin(inds)] = 1
        cind[0] = 2
        
        # If the new index is a new maximum, update and recalculate densities.
        if ind > imax:
            imax = ind
            xa = np.column_stack((xp, uniform(0, 1, size=len(xp))))
            xa[:, 1] = -0.01 - 0.08 * xa[:, 1]
            kde_xa = KernelDensity(bandwidth=h, kernel='epanechnikov').fit(xa[:, 0].reshape(-1, 1))
            log_dens_xa = kde_xa.score_samples(xg)
            fa = np.column_stack((xg.flatten(), np.exp(log_dens_xa)))
            
        # If the new index is a new minimum, update and recalculate densities.
        if ind < imin:
            imin = ind
            xi = np.column_stack((xp, uniform(0, 1, size=len(xp))))
            xi[:, 1] = -0.11 - 0.08 * xi[:, 1]
            kde_xi = KernelDensity(bandwidth=h, kernel='epanechnikov').fit(xi[:, 0].reshape(-1, 1))
            log_dens_xi = kde_xi.score_samples(xg)
            fi = np.column_stack((xg.flatten(), np.exp(log_dens_xi)))

            pmax = i
            mini = p

    # Return a dictionary of results
    return {
        'xa': xa, 
        'xi': xi, 
        'fa': fa, 
        'fi': fi, 
        'pind': pind, 
        'cind': cind
    }


def sphere(x):
    # Subtract column means to center data.
    x_centered = x - np.mean(x, axis=0)

    # Compute covariance matrix of centered data.
    cov_matrix = np.cov(x_centered, rowvar=False)

    # SVD of covariance matrix.
    u, s, vh = np.linalg.svd(cov_matrix)

    # Scale u by inverse square root of s.
    s_matrix = np.diag(1 / np.sqrt(s))
    transformation_matrix = np.dot(u, s_matrix)

    # Transform data using scaled matrix.
    x_sphered = np.dot(x_centered, transformation_matrix)
    
    return x_sphered


# Load data
x = pd.read_table("bostonh.dat", delim_whitespace=True, header=None)
x_drop = x.drop(x.columns[3], axis=1)
x_transformed = sphere(x_drop)

h = 2.62 * len(x_transformed) ** (-1/5) # Calculate the bandwidth
n = 50 # Set the number of projections

inde = ppexample(x_transformed, h, n)


# Plotting
fig, axs = plt.subplots(2, 1, gridspec_kw={'height_ratios': [3, 1]}, figsize=(9, 7))

# First subplot
ax = axs[0]
ax.scatter(inde['xa'][:100, 0], inde['xa'][:100, 1], facecolors='none', edgecolors='r', marker='o', s=20)  # Red hollow circles for 'xa'
ax.scatter(inde['xa'][100:, 0], inde['xa'][100:, 1], facecolors='none', edgecolors='r', marker='^', s=20)  # Red hollow triangles for 'xa'
ax.scatter(inde['xi'][:100, 0], inde['xi'][:100, 1], facecolors='none', edgecolors='b', marker='o', s=20)  # Blue hollow circles for 'xi'
ax.scatter(inde['xi'][100:, 0], inde['xi'][100:, 1], facecolors='none', edgecolors='b', marker='^', s=20)  # Blue hollow triangles for 'xi'
# Plot density lines
ax.plot(inde['fi'][:, 0], inde['fi'][:, 1], 'b-', linewidth=2)  # Blue line for 'fi' density
ax.plot(inde['fa'][:, 0], inde['fa'][:, 1], 'r-', linewidth=2)  # Red line for 'fa' density
# Plot standard normal density in green
ax.plot(np.linspace(-4, 4, 100), scipy_norm.pdf(np.linspace(-4, 4, 100)), 'g-', linewidth=2) 

ax.set_xlim(-4, 4)
ax.set_ylim(-0.2, max(np.max(inde['fi'][:, 1]), np.max(inde['fa'][:, 1])))
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_title('50 directions')

# Second subplot
ax = axs[1]
ax.plot(inde['pind'][:, 0], inde['pind'][:, 1], 'ko', markerfacecolor='none')
for idx, val in enumerate(inde['cind']):
    if val == 4:
        ax.plot(inde['pind'][idx, 0], inde['pind'][idx, 1], 'ro', markerfacecolor='none')  # Red
    elif val == 1:
        ax.plot(inde['pind'][idx, 0], inde['pind'][idx, 1], 'bo', markerfacecolor='none')  # Blue
    elif val == 2:
        ax.plot(inde['pind'][idx, 0], inde['pind'][idx, 1], 'go', markerfacecolor='none')  # Green

plt.tight_layout()
plt.show()

# same but with transformed data
xt = x_drop.copy()
for i in [0, 2, 4, 5, 7, 8, 9, 13]:
    xt[i] = np.log(x_drop[i])
    
xt[1] = x_drop[1]/10
xt[6] = (x_drop[6]**2.5)/10000
xt[10] = np.exp(0.4 * x_drop[10])/1000
xt[11] = (x_drop[11])/100
xt[12] = np.sqrt(x_drop[12])

x_transformed = sphere(xt)

h = 2.62 * len(x_transformed) ** (-1/5) # Calculate the bandwidth
n = 50 # Set the number of projections

inde = ppexample(x_transformed, h, n)

# Plotting
fig, axs = plt.subplots(2, 1, gridspec_kw={'height_ratios': [3, 1]}, figsize=(9, 7))

# First subplot
ax = axs[0]
ax.scatter(inde['xa'][:100, 0], inde['xa'][:100, 1], facecolors='none', edgecolors='r', marker='o', s=20)  # Red hollow circles for 'xa'
ax.scatter(inde['xa'][100:, 0], inde['xa'][100:, 1], facecolors='none', edgecolors='r', marker='^', s=20)  # Red hollow triangles for 'xa'
ax.scatter(inde['xi'][:100, 0], inde['xi'][:100, 1], facecolors='none', edgecolors='b', marker='o', s=20)  # Blue hollow circles for 'xi'
ax.scatter(inde['xi'][100:, 0], inde['xi'][100:, 1], facecolors='none', edgecolors='b', marker='^', s=20)  # Blue hollow triangles for 'xi'
# Plot density lines
ax.plot(inde['fi'][:, 0], inde['fi'][:, 1], 'b-', linewidth=2)  # Blue line for 'fi' density
ax.plot(inde['fa'][:, 0], inde['fa'][:, 1], 'r-', linewidth=2)  # Red line for 'fa' density
# Plot standard normal density in green
ax.plot(np.linspace(-4, 4, 100), scipy_norm.pdf(np.linspace(-4, 4, 100)), 'g-', linewidth=2) 

ax.set_xlim(-4, 4)
ax.set_ylim(-0.2, max(np.max(inde['fi'][:, 1]), np.max(inde['fa'][:, 1])))
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_title('50 directions')

# Second subplot
ax = axs[1]
ax.plot(inde['pind'][:, 0], inde['pind'][:, 1], 'ko', markerfacecolor='none')
for idx, val in enumerate(inde['cind']):
    if val == 4:
        ax.plot(inde['pind'][idx, 0], inde['pind'][idx, 1], 'ro', markerfacecolor='none')  # Red
    elif val == 1:
        ax.plot(inde['pind'][idx, 0], inde['pind'][idx, 1], 'bo', markerfacecolor='none')  # Blue
    elif val == 2:
        ax.plot(inde['pind'][idx, 0], inde['pind'][idx, 1], 'go', markerfacecolor='none')  # Green

plt.tight_layout()
plt.show()
