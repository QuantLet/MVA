<div style="margin: 0; padding: 0; text-align: center; border: none;">
<a href="https://quantlet.com" target="_blank" style="text-decoration: none; border: none;">
<img src="https://github.com/StefanGam/test-repo/blob/main/quantlet_design.png?raw=true" alt="Header Image" width="100%" style="margin: 0; padding: 0; display: block; border: none;" />
</a>
</div>

```
Name of QuantLet: MVAlassocontour

Published in: Applied Multivariate Statistical Analysis

Description: 'Plots the Lasso solution under the least squares loss function. The contour plots of the quadratic form objective function are produced which are centered at the least squares solution (beta_1,beta_2)^t = (6,7)^t in the two-dimensional case for the case of both the non-orthonormal and orthonormal design. The tuning parameter s being equal to 4.'

Keywords: contour, least-squares, lasso, lasso shrinkage, plot, graphical representation

See also: LCPvariance, MVAlassologit, MVAlassoregress, SMSlassocar, SMSlassoridge

Author: Sergey Nasekin

Author[Python]: 'Matthias Fengler, Liudmila Gorkun-Voevoda'

Submitted: Sun, May 03 2015 by Awdesch Melzer

Submitted[Python]: 'Wed, April 22 2020 by Liudmila Gorkun-Voevoda'

Input: 

- s: lasso tuning parameter

- orthonorm: logical (1 if orthonormal design is required to be plotted, 0 if non-orthonormal)

- beta: basic OLS solution around which the quadratic form objective function is centered.

Example: 

- 1: Lasso solution in the general design case.

- 2: Lasso solution in the orthonormal design case.

```
<div align="center">
<img src="https://raw.githubusercontent.com/QuantLet/MVA/master/QID-2963-MVAlassocontour/MVAlassocontour_1.png" alt="Image" />
</div>

<div align="center">
<img src="https://raw.githubusercontent.com/QuantLet/MVA/master/QID-2963-MVAlassocontour/MVAlassocontour_1_python.png" alt="Image" />
</div>

<div align="center">
<img src="https://raw.githubusercontent.com/QuantLet/MVA/master/QID-2963-MVAlassocontour/MVAlassocontour_2.png" alt="Image" />
</div>

<div align="center">
<img src="https://raw.githubusercontent.com/QuantLet/MVA/master/QID-2963-MVAlassocontour/MVAlassocontour_2_python.png" alt="Image" />
</div>

