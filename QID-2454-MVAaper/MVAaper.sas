
* Import the data;
data b2;
  infile '/folders/myfolders/Sas-work/data/bank2.dat';
  input x1-x6; 
run;

proc iml;
  * Read standardized data into a matrix;
  use b2;
    read all var _ALL_ into x; 
  close b2;
  
  xg = x[1:100, ];
  xf = x[101:200, ];

  mg    = xg[:,];                              * mean forged;
  mf    = xf[:,];                              * mean genuine;
  m     = (mf + mg)/2;                         * total mean;
  s     = (99 * cov(xg) + 99 * cov(xf))/198;   * sd;
  alpha = inv(s) * (mg - mf)`;
  
  miss1 = 0;
  do i = 1 to nrow(xg[, 1]);
    if ((xg[i, ] - m) * alpha < 0) then
      miss1 = miss1 + 1;
  end;
  
  miss2 = 0;
  do i = 1 to nrow(xf[, 1]);
    if ((xf[i, ] - m) * alpha > 0) then
      miss2 = miss2 + 1;
  end;
  
  aper = (miss1 + miss2)/nrow(x[, 1]);
  
  print 'Genuine banknotes classified as forged:', miss1;
  print 'Forged banknotes classified as genuine:', miss2;
  print 'APER (apparent error rate):', aper; 
quit;