
* Import the data;
data pull;
  infile '/folders/myfolders/Sas-work/data/pullover.dat';
  input x1-x4; 
run;

proc iml;
  use pull;
    read all var _ALL_ into x;
  close pull;
  
  y = x[, 1];                                               * first column (sales);
  n = nrow(y);                                              * number of observations;
  x = repeat(1, nrow(x),1) || x[, 2] || x[, 3] || x[, 4];   * ones, second to fourth column;
  p = ncol(x);                                              * number of parameters in beta;
  b = inv(x` * x) * x` * y;                                 * MLE (LSE);
  print b[c ='MLE (LSE)'];
  
  aa  = {0, 1, 0.5, 0};                                     * matrix A;
  a   = 0;                                                  * constant a;
  q   = nrow(a);                                            * number of parameters in constr. beta;
  bc = b - inv(x` * x) * aa * inv(aa` * inv(x` * x) * aa) * (aa` * b - a); * constrained MLE;
  print bc[c ='constrained MLE'];
  
  lrt1 = t(y - x * bc) * (y - x * bc);
  lrt2 = t(y - x * b) * (y - x * b);
  lrt = n * log(lrt1/lrt2);                                 * LR test statistic;
  print lrt[c ='LR test statistic'];
  
  p2 = cdf("CHISQUARE", lrt, q);
  print p2[c ='prob to reject hypothesis'],aa,b;
  
  ft1  = (aa` * b - a) * inv(aa` * inv(x` * x) * aa) * (aa` * b - a)`;
  ft2  = lrt2;
  ft   = ((n - p)/q) * ft1/ft2;                             * F test statistic; 
  print ft[c ='F test statistic'];                   
  
  pf = cdf("F", ft, q, n);                                  * prob to reject hypothesis;
  print pf[c ='prob to reject hypothesis'];                          

quit;
