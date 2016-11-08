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
  
  create dat from datax[colname={"t1" "t2" "t3" "t4" "t5" "t6" "t7" "t8" "t9" "t10" "t11" "t12" "t13"}];
    append from datax;
  close dat;
  
  create dat2 from xt[colname={"t1" "t2" "t3" "t4" "t5" "t6" "t7" "t8" "t9" "t10" "t11" "t12" "t13" "t14"}];
    append from xt;
  close dat2;

quit;

* standardize the data matrix;
proc standard data = dat mean = 0 std = 1 out = ydat;
  var t1-t13;
run;

* euclidean distance matrix;
proc distance data = ydat out = dist method = euclid nostd;
  var interval (t1--t13);
run;

data newdist;
  id + 1;
  set dist;
run;

* cluster analysis with ward algorithm;
ods graphics on;
proc cluster data = newdist(type = distance)
    method = ward 
    plots(only) = (Pseudo Dendrogram(vertical))
    print = 0
    outtree = stat 
    noprint;
  id id;
  title 'Ward Dendrogram for standardized data';
run;
ods graphics off;

* define the clusters;
proc tree data = stat noprint out = sol nclusters = 2;
  id id;
run;

data t3;
  set sol;
  if CLUSTER = 1;
run;

data t4;
  set sol;
  if CLUSTER = 2;
run;

data ydat2;
  id + 1;
  set ydat;
run;

proc iml;
  * all data;
  use ydat2;
    read all var _ALL_ into main; 
  close ydat2;
  
  * cluster 1;
  use t3;
    read all var _ALL_ into r3; 
  close t3;
  
  * cluster 2;
  use t4;
    read all var _ALL_ into r4; 
  close t4;
  
  * original data;
  use dat2;
    read all var _ALL_ into z; 
  close dat2;
  
  idd1 = r3[,1];
  idd2 = r4[,1];
  
  main = main[,2:14];
  d1 = main[idd1,];
  d2 = main[idd2,];
  
  m1 = (d1[:,]);                      * mean of first cluster;
  m2 = (d2[:,]);                      * mean of second cluster;
  m  = (m1 + m2) / 2;                 * mean of both clusters;
  s  = ((nrow(d1) - 1) * cov(d1) + (nrow(d2) - 1) * cov(d2))/(nrow(z) - 2);    * common variance matrix;
  alpha = inv(s) * (m1 - m2)`;        * alpha for the discrimination rule;
  
  * APER for clusters of Boston houses;
  mis1  = sum((d1 - m) * alpha < 0);  * misclassified 1;
  mis2  = sum((d2 - m) * alpha > 0);  * misclassified 2;
  corr1 = sum((d1 - m) * alpha > 0);  * correct 1;
  corr2 = sum((d2 - m) * alpha < 0);  * correct 2;
  aper  = (mis1 + mis2)/nrow(z);      * APER (apparent error rate);
  alph  = (main - repeat(m, nrow(main), 1)) * alpha;
  
  n = nrow(z);
  z = (1:n)` || z;
  
    * marker for cluster 1;
  do i = 1 to nrow(idd1);
    z[idd1[i],1] = 1;
  end;
  
  * marker for cluster 2;
  do i = 1 to nrow(idd2);
    z[idd2[i],1] = 2;
  end;
  
  * discrimination scores;
  t = 0.05 * randnormal(n, 0, 1);
  do i = 1 to n;
    t[i] = z[i,1] + t[i];
  end;

  p = z[,1] || alph || t;
  
  id = p[,1];
  x1 = p[,2];
  x2 = p[,3];

  create plot var {"x1" "x2" "id"};
    append;
  close plot;
quit;

proc sgplot data = plot
    noautolegend;
  title 'Discrimination scores';
  scatter x = x1 y = x2 / colorresponse = id colormodel = (red blue)
    markerattrs = (symbol = circlefilled);
  refline 0 / axis = x lineattrs = (color = black thickness = 2);
  xaxis display = none;
  yaxis display = none;
run;





