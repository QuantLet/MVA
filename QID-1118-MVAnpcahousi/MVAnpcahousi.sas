* Import the data;
data bostonh;
  infile '/folders/myfolders/data/bostonh.dat';
  input temp1-temp14;
run;

proc iml;
  * Read data into a matrix;
  use bostonh;
    read all var _ALL_ into datax; 
  close bostonh;
  
  xt = datax;
  xt[, 1]  = log(datax[, 1]);
  xt[, 2]  = datax[, 2]/10;
  xt[, 3]  = log(datax[, 3]);
  xt[, 5]  = log(datax[, 5]);
  xt[, 6]  = log(datax[, 6]);
  xt[, 7]  = (datax[, 7] ## (2.5))/10000;
  xt[, 8]  = log(datax[, 8]);
  xt[, 9]  = log(datax[, 9]);
  xt[, 10] = log(datax[, 10]);
  xt[, 11] = exp(0.4 * datax[, 11])/1000;
  xt[, 12] = datax[, 12]/100;
  xt[, 13] = sqrt(datax[, 13]);
  xt[, 14] = log(datax[, 14]);
  datax = xt[,1:3] || xt[,5:14];
  
  n1  = nrow(datax);
  n2  = ncol(datax);
  x   = (datax - repeat(datax[:], n1, n2)) / sqrt((n1 - 1) * var(datax) / n1); * standardizes the data;
  eig = (n1 - 1) * cov(x)/n1; * spectral decomposition;
  e   = eigval(eig);
  v   = eigvec(eig);
  x1  = x - repeat(x[:], nrow(x), ncol(x));
  r1  = x1 * v;
  r   = corr(r1 || x);
  
  * correlations between variables and pc's;
  r12  = r[14:26, 1:2];
  r13  = r[14:26, 1] || r[14:26, 3];
  r32  = r[14:26, 3] || r[14:26, 2];
  r123 = r[14:26, 1:2];
  
  pi = constant("pi");
  uc = (cos((0:360)/180 * pi) // sin((0:360)/180 * pi))`;
  u1 = uc[,1];
  u2 = uc[,2];
  names = {"X1", "X2", "X3", "X5", "X6", "X7", 
    "X8", "X9", "X10", "X11", "X12", "X13", "X14"};
  
  x11  = -r12[,1];
  x12  = r12[,2]; 
  x21  = -r32[,1];
  x22  = r32[,2];
  x31  = -r13[,1];
  x32  = -r13[,2];
  x41  = -r123[,1];
  x42  = r123[,2]; 
   
  create plot var {"x11" "x12" "x21" "x22" "x31" "x32" "x41" "x42" "u1" "u2" "names"};
    append;
  close plot;
quit;
  
proc sgplot data = plot
    noautolegend;
  title 'Boston Housing';
  series  x = u1 y = u2 / lineattrs = (color = blue THICKNESS = 2);
  scatter x = x11 y = x12 / markerattrs = (color = black symbol = circlefilled)
    datalabel = names;
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'First PC';
  yaxis label = 'Second PC';
run;

proc sgplot data = plot
    noautolegend;
  title 'Boston Housing';
  series  x = u1 y = u2 / lineattrs = (color = blue THICKNESS = 2);
  scatter x = x21 y = x22 / markerattrs = (color = black symbol = circlefilled)
    datalabel = names;
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'Third PC';
  yaxis label = 'Second PC';
run;
  
proc sgplot data = plot
    noautolegend;
  title 'Boston Housing';
  series  x = u1 y = u2 / lineattrs = (color = blue THICKNESS = 2);
  scatter x = x31 y = x32 / markerattrs = (color = black symbol = circlefilled)
    datalabel = names;
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'First PC';
  yaxis label = 'Third PC';
run;

proc sgplot data = plot
    noautolegend;
  title 'Boston Housing';
  series  x = u1 y = u2 / lineattrs = (color = blue THICKNESS = 2);
  scatter x = x41 y = x42 / markerattrs = (color = black symbol = circlefilled)
    datalabel = names;
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'X';
  yaxis label = 'Y';
run;
  