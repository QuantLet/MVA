
* Import the data;
data timebudget;
  infile '/folders/myfolders/data/timebudget.dat';
  input temp1-temp10;
run;

proc iml;
  * Read data into a matrix;
  use timebudget;
    read all var _ALL_ into x; 
  close timebudget;
  
  n  = nrow(x); 
  p  = ncol(x);
  x  = (x - repeat(x(|:,|), n, 1)) / sqrt((n - 1) * var(x)); * standardizes the data;
  e  = x * x` / n;
  e1 = eigval(e);
  a  = eigvec(e)[, 1:2];  * first two Eigenvectors corresponding to largest 2 Eigenvalues;
  w  = a # sqrt(repeat(e1[1:2]`, nrow(a), 1)); *coordinates of individuals;
  
  g  = t(x) * x; 
  g1 = eigval(g);
  b  = eigvec(g)[, 1:2];  * first two Eigenvectors corresponding to largest 2 Eigenvalues;
  z  = b # sqrt(repeat(g1[1:2]`, nrow(b), 1)); *coordinates of variables;
  
  pi = constant("pi");
  uc = (cos((0:360)/180 * pi) // sin((0:360)/180 * pi))`;
  u1 = uc[,1];
  u2 = uc[,2];
  
  w1 = w[,1];
  w2 = w[,2];
  z1 = z[,1];
  z2 = z[,2];
  names1 = {"maus", "waus", "wnus", "mmus", "wmus", "msus", "wsus", "mawe", "wawe", 
    "wnwe", "mmwe", "wmwe", "mswe", "wswe", "mayo", "wayo", "wnyo", "mmyo", "wmyo", 
    "msyo", "wsyo", "maes", "waes", "wnes", "mmes", "wmes", "mses", "wses"};
  names2 = {"prof", "tran", "hous", "kids", "shop", "pers", "eati", "slee", "tele", 
    "leis"};
  create plot var {"w1" "w2" "z1" "z2" "u1" "u2" "names1" "names2"};
    append;
  close plot;
quit;

proc sgplot data = plot
    noautolegend;
  title 'Time Budget data';
  scatter x = w1 y = w2 / datalabel = names1 
    markerattrs = (color = blue);
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'First Factor - Individuals';
  yaxis label = 'Second Factor - Individuals';
run;

proc sgplot data = plot
    noautolegend;
  title 'Time Budget data';
  series  x = u1 y = u2 / lineattrs = (color = blue THICKNESS = 2);
  scatter x = z1 y = z2 / markerattrs = (color = blue)
    datalabel = names2;
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'First Factor - Expenditures';
  yaxis label = 'Second Factor - Expenditures';
run;




