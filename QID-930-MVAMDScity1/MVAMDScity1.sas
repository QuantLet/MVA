
proc iml;
  * matrix "multiplication" where missing values are propagated;
  start MVMult(A, B);
    C = j(nrow(A), ncol(B), .);
    rows = loc(countmiss(A, "ROW")=0);
    cols = loc(countmiss(B, "COL")=0);
    if ncol(rows)>0 & ncol(cols)>0 then
      C[rows, cols] = A[rows,] * B[,cols];
    return(C);
  finish;

  * Intercity road distances;
  ber  = {0, 214, 279, 610, 596, 237};
  dre  = {214, 0, 492, 533, 496, 444};
  ham  = {279, 492, 0, 520, 772, 140};
  kob  = {610, 533, 520, 0, 521, 687};
  mue  = {596, 496, 772, 521, 0, 771};
  ros  = {237, 444, 140, 687, 771, 0};
  
  dist = ber || dre || ham || kob || mue || ros;
  
  * a, b, h, i are matrices;
  a = (dist ## 2) * (-0.5);
  u = j(6,1,1);
  i = diag(u);
  h = i - (1/6 * (u * t(u)));
  b = h * a * h;   * Determine the inner product matrix;
  V = eigvec(b);
  L = diag(eigval(b)) ## 0.5;
  x = MVMult(V,L); * Determine the coordinate matrix;
  
  x1 = x[,1];
  x2 = x[,2];
  cities = {'Berlin', 'Dresden', 'Hamburg', 'Koblenz', 'Muenchen', 'Rostock'};
  
  create plot var {"x1" "x2" "cities"};
    append;
  close plot;
quit;

proc sgplot data = plot;
  title 'Initial Configuration';
  scatter x = x1 y = x2 / datalabel = cities
    datalabelattrs = (color = blue) datalabelpos = right;
  xaxis min = -500 max = 700 label = 'NORTH - SOUTH - DIRECTION in km';
  yaxis min = -500 max = 300 label = 'EAST - WEST - DIRECTION in km';
run;



