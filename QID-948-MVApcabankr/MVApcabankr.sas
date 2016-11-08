
* Import the data;
data bank2;
  infile '/folders/myfolders/data/bank2.dat';
  input temp1-temp6;
run;

proc iml;
  * Read data into a matrix;
  use bank2;
    read all var _ALL_ into x; 
  close bank2;
  
  x[, 1] = x[, 1] / 10;
  x[, 2] = x[, 2] / 10;
  x[, 3] = x[, 3] / 10;
  x[, 6] = x[, 6] / 10;
  
  n  = nrow(x);
  e  = (n - 1) * cov(x)/n; * calculates eigenvalues and eigenvectors and sorts them by size; 
  e1 = 1:6;
  e2 = eigval(e);
  id = (repeat ({1}, 1, 100) || repeat ({2}, 1, 100))`;
  x  = x * eigvec(e);      * data multiplied by eigenvectors;
  
  x1 = x[,1];
  x2 = x[,2];
  x3 = x[,3];
  create plot var {"x1" "x2" "x3" "e1" "e2" "id"};
    append;
  close plot;
quit;

proc sgplot data = plot
    noautolegend;
  title 'First vs. Second PC';
  scatter x = x1 y = x2 / colorresponse = id colormodel = (blue red);
  xaxis label = 'PC1';
  yaxis label = 'PC2';
run;

proc sgplot data = plot
    noautolegend;
  title 'Second vs. Third PC';
  scatter x = x2 y = x3 / colorresponse = id colormodel = (blue red);
  xaxis label = 'PC2';
  yaxis label = 'PC3';
run;

proc sgplot data = plot
    noautolegend;
  title 'First vs. Third PC';
  scatter x = x1 y = x3 / colorresponse = id colormodel = (blue red);
  xaxis label = 'PC1';
  yaxis label = 'PC3';
run;

proc sgplot data = plot
    noautolegend;
  title 'Eigenvalues of S';
  scatter x = e1 y = e2 / markerattrs = (color = blue);
  xaxis label = 'Index';
  yaxis label = 'Lambda';
run;

