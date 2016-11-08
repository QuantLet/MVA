
* Import the data;
data b2;
  count + 1;
  infile '/folders/myfolders/data/bank2.dat';
  input t1-t6;
run;

* sample of 20 randomly chosen bank notes from data;
proc surveyselect data = b2 method = SRS 
  sampsize = 20 out = bank2 noprint;
  id _all_;
run;

proc iml;
  * Read data into a matrix;
  use bank2;
    read all var _ALL_ into xx; 
  close bank2;
  
  num = xx[,1];
  xx = xx[,2:7];
  
  * PCA;
  x = xx - repeat(xx(|:,|), nrow(xx), 1);
  e  = cov(x);         * spectral decomposition;
  eva = eigval(e);
  eve = eigvec(e);
  y = (x * eve)[, 1:2]; * first two eigenvectors;
  
  x1 = y[,1];
  x2 = -y[,2];
  
  create plot var {"x1" "x2" "num"};
    append;
  close plot;
quit;

* Plot 1: PCA;
proc sgplot data = plot    
    noautolegend;
  title '20 Swiss bank notes';
  scatter x = x1 y = x2 / markerattrs = (color = blue symbol = circlefilled)
    datalabel = num;
  xaxis min = -5 max = 4.5 label = 'First PC';
  yaxis min = -5 max = 4 label = 'Second PC';
run;

* Plot 2: Dendrogram for the 20 bank notes after applying the Ward algorithm;
proc distance data = bank2 out = dist method = euclid nostd;
  var interval(t1 t2 t3 t4 t5 t6);
run;

data newdist;
  set dist;
  set plot;
  drop x1 x2;
run;

ods graphics on;
proc cluster data = newdist(type = distance)
    method = ward 
    plots(only) = (Pseudo Dendrogram(vertical))
    print = 0
    outtree = stat;
  id num;
  title 'Ward Dendrogram for 20 Swiss bank notes';
run;
ods graphics off;

* Plot 3: PCA with clusters;
proc tree data = stat noprint out = sol level= 0.4;
  id num;
run;

proc sort data = sol;
  by num;
run;

proc sort data = plot;
  by num;
run;

data plot2;
  set plot;
  set sol;
run;

proc sgplot data = plot2
    noautolegend;
  title '20 Swiss bank notes, cut height 60';
  scatter x = x1 y = x2 / colorresponse = CLUSTER colormodel = (red blue)
    markerattrs = (symbol = circlefilled)
    datalabel = num;
  xaxis min = -5 max = 4.5 label = 'First PC';
  yaxis min = -5 max = 4 label = 'Second PC';
run;