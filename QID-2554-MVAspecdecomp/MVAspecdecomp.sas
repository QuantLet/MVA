
proc iml; 
  rho = 0.9;                             * Set the covariance;
  a = ({1} || rho ) // (rho || {1});     * Covariance matrix;
  lambda = diag(eigval(a));              * Diagonal matrix of eigenvalues;
  gamma = eigvec(a);                     * Gamma transformation matrix;
  
  * Check whether the decomposition yiels a;
  p = a - gamma * lambda * gamma`;      * Should yield a matrix of zeros (approx);
  print p; 
quit;