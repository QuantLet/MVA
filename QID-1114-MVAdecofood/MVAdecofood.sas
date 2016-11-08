
* Import the data;
data food;
  infile '/folders/myfolders/data/food.dat';
  input temp1 $ temp2-temp8;
run;

proc iml;
  * Read data into a matrix;
  use food;
    read all var _ALL_ into x; 
  close food;

  n = nrow(x);
  p = ncol(x);
  
  one = j(n, n, 1);
  h   = i(n) - one/n;
  a   = x - repeat(x(|:,|), n, 1);
  d   = diag(1 / sqrt(a[##,] / n));
  
  xs  = h * x * d;  * standardized data;
  xs1 = xs / sqrt(n);
  xs2 = xs1` * xs1;
  
  * spectral decomposition;
  lambda = eigval(xs2);
  gamma  = eigvec(xs2);
  
  * coordinates of food;
  w = gamma # repeat(sqrt(lambda)`, nrow(gamma), 1);
  w = w[, 1:2];
  
  * coordinates of families;
  z1 = xs1 * gamma;
  z2 = sqrt(n/p) * z1;
  z  = z2[, 1:2];
  
  namew = {"bread", "veget", "fruit", "meat", "poult", "milk", "wine"};
  namez = {"ma2", "em2", "ca2", "ma3", "em3", "ca3", "ma4", "em4", "ca4", "ma5", "em5", "ca5"};

  x1  = w[,1];
  x2  = w[,2]; 
  x3  = z[,1];
  x4  = z[,2]; 
      
  create plot var {"x1" "x2" "x3" "x4" "namew" "namez"};
    append;
  close plot;
quit;

proc sgplot data = plot
    noautolegend;
  title 'Food';
  scatter x = x1 y = x2 / markerattrs = (symbol = circlefilled)
    datalabel = namew;
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'W[,1]';
  yaxis label = 'W[,2]';
run;

proc print data = plot(obs = 7) noobs label;
  var namew x1 x2;
  label namew='names' x1='W[,1]' x2 = 'W[,2]';
run;


proc sgplot data = plot
    noautolegend;
  title 'Families';
  scatter x = x3 y = x4 / markerattrs = (symbol = circlefilled)
    datalabel = namez;
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'Z[,1]';
  yaxis label = 'Z[,2]';
run;

proc print data = plot noobs label;
  var namez x3 x4;
  label namez='names' x1='W[,1]' x2 = 'W[,2]';
run;

