
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
  
  xg = x[1:100, ];   * Group first  100 observations;
  xf = x[101:200, ]; * Group second 100 observations;
  mg = xg(|:,|);
  mf = xf(|:,|);
  m  = (mg + mf)/2;
  w  = 100 * (cov(xg) + cov(xf));    * matrix w for within sum-of-squares;
  d  = mg - mf;                      * Difference in means;
  a  = inv(w) * d`;                  * Determine the factors for linear combinations;
  yg = (xg - repeat(m, 100, 1)) * a; * Discriminant rule for genuine notes;
  yf = (xf - repeat(m, 100, 1)) * a; * Discriminant rule for forged notes;
  
  xgtest = yg;
  sg = sum(xgtest < 0);  * Number of misclassified genuine notes;
  
  xftest = yf;
  sf = sum(xftest > 0);  * Number of misclassified forged notes;

  create plot var {"yg" "yf"};
    append;
  close plot;
quit;

data plot;
  set plot;
  rename yg = Genuine yf = Forged;
  ods graphics on;
  proc kde data=plot;
    title 'Densities of Projections of Swiss bank notes';
    univar Genuine Forged / plots = (densityoverlay) noprint;
  run;
  ods graphics off;
quit;



