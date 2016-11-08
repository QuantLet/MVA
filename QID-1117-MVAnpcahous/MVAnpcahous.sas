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
  x   = (datax - repeat(datax(|:,|), n1, 1)) / sqrt((n1 - 1) * var(datax) / n1); * standardizes the data;
  eig = (n1 - 1) * cov(x)/n1; * spectral decomposition;
  e   = eigval(eig);
  v   = eigvec(eig);
  
  perc = e/sum(e);            * explained variance;
  cum  = cusum(e)/sum(e);     * cumulated explained percentages;
  xv   = x * v;               * principal components;
  
  h = x[, 13];
  s = mean(h);
  
  * mark more expensive houses with "1", cheaper houses with "2";
  do i = 1 to nrow(h);
    if h[i] >= s then h[i] = 1; else h[i] = 2; 
  end;
  id1 = h;
  
  * mark houses which are close to the Charles River with "1"; 
  id2 = xt[, 4] + 1;
  
  x1  = xv[,1];
  x2  = xv[,2];     
  create plot var {"x1" "x2" "id1" "id2"};
    append;
  close plot;
quit;

proc sgplot data = plot
    noautolegend;
  title 'First vs. Second PC';
  scatter x = x1 y = x2 / colorresponse = id1 colormodel = (red black)
    markerattrs = (symbol = circlefilled);
  xaxis label = 'PC1';
  yaxis label = 'PC2';
run;

proc sgplot data = plot
    noautolegend;
  title 'First vs. Second PC';
  scatter x = x1 y = x2 / colorresponse = id2 colormodel = (black red)
    markerattrs = (symbol = circlefilled);
  xaxis label = 'PC1';
  yaxis label = 'PC2';
run;