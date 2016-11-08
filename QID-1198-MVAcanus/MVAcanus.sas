
* Import the data;
data uscrime;
  infile '/folders/myfolders/data/uscrime_sas.dat';
  input temp1-temp11;
run;

data ushealth;
  infile '/folders/myfolders/data/ushealth_sas.dat';
  input t1 $ t2-t12;
run;

proc iml;
  * Read data into a matrix;
  use uscrime;
    read all var _ALL_ into x; 
  close uscrime;
  
  use ushealth;
    read all var _ALL_ into y; 
  close ushealth;
  
  x = x[, 3:9];
  y = y[, 3:9];
  
  * Estimation of covariance matrices;
  s = cov(x || y);
  sxx = s[1:ncol(x), 1:ncol(x)];
  sxy = s[1:ncol(x), 1+ncol(x):ncol(x)+ncol(y)];
  syx = sxy;
  syy = s[1+ncol(x):ncol(x)+ncol(y), 1+ncol(x):ncol(x)+ncol(y)];
  
  * Estimation of the matrix K and its singular value decomposition;
  
  ex = eigval(sxx);  * eigenvalues of Sxx;
  vx = eigvec(sxx);  * eigenvectors of Sxx;
  
  ey = eigval(syy);  * eigenvalues of Syy;
  vy = eigvec(syy);  * eigenvectors of Syy;

  k  = vx * diag(1/sqrt(ex)) * vx` * sxy * vy * diag(1/sqrt(ey)) * vy`;
  
  call svd(u,q,v,k);
  
  * Estimated canonical correlation vectors (a and b) and canonical variables (eta and phi);
  a = vx * diag(1/sqrt(ex)) * vx` * u;
  b = vy * diag(1/sqrt(ey)) * vy` * v;
  eta = x * a;
  phi = y * b;
  
  print a, b, eta, phi;
quit;

