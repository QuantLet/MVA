
* Import the data;
data food;
  infile 'food.dat';
  input t1 $ t2-t8;
  drop t1;
run;

* standardize the data matrix;
proc standard data = food mean = 0 std = 1 out = y;
  var t2-t8;
run;

proc iml;
  * Read data into a matrix;
  use y;
    read all var _ALL_ into f; 
  close y;
  
  names = {"MA2", "EM2", "CA2", "MA3", "EM3", "CA3", "MA4", "EM4", "CA4", 
    "MA5", "EM5", "CA5"};
  
  * PCA;
  x = f - repeat(f(|:,|), nrow(f), 1);
  e  = cov(x);         * spectral decomposition;
  eva = eigval(e);
  eve = eigvec(e);
  y = (x * eve)[, 1:2]; * first two eigenvectors;
  
  x1 = y[,1];
  x2 = -y[,2];
  
  create plot var {"x1" "x2" "names"};
    append;
  close plot;
quit;

* Plot 1: PCA;
proc sgplot data = plot    
    noautolegend;
  title 'French Food data';
  scatter x = x1 y = x2 / markerattrs = (color = blue symbol = circlefilled)
    datalabel = names;
  xaxis min = -5 max = 4.5 label = 'First PC';
  yaxis min = -5 max = 4 label = 'Second PC';
run;

* Plot 2: Dendrogram for the standardized food.dat after Ward algorithm;
proc distance data = y out = dist method = euclid nostd;
  var interval(t2 t3 t4 t5 t6 t7 t8);
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
  id names;
  title 'Ward Dendrogram for French Food';
run;
ods graphics off;

* Plot 3: PCA with clusters;
proc tree data = stat noprint out = sol level= 0.4;
  id names;
run;

proc sort data = sol;
  by names;
run;

proc sort data = plot;
  by names;
run;

data plot2;
  set plot;
  set sol;
run;

proc sgplot data = plot2
    noautolegend;
  title 'French Food data, cut height 60';
  scatter x = x1 y = x2 / colorresponse = CLUSTER colormodel = (red blue)
    markerattrs = (symbol = circlefilled)
    datalabel = names;
  xaxis min = -5 max = 4.5 label = 'First PC';
  yaxis min = -5 max = 4 label = 'Second PC';
run;
