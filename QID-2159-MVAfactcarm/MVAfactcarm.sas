* Import the data;
data carmean;
  infile '/folders/myfolders/data/carmean.dat';
  input temp1 $ temp2-temp9;
run;

proc iml;
  * Read data into a matrix;
  use carmean;
    read all var _ALL_ into x; 
  close carmean;
  
  colnames = {"economic", "service", "value", "price", "look", "sporty", "security", 
    "easy"}; 
  
  * correlation matrix;
  r = corr(x);
  m = r;
  
  do i = 1 to ncol(r);
    m[i, i] = r[i, i] - 1;
  end;
  
  psi = j(8,8,1);
  
  do i = 1 to 8;
    psi[i, i] = 1 - max(abs(m[, i]));
  end;
  
  * spectral decomposition;
  eig = r - psi;
  ee  = eigval(eig)[1:2];
  vv  = eigvec(eig)[, 1:2];
  vv  = vv[, 1:2] # sign(vv[2, 1:2]);
  q1  = sqrt(ee[1]) # vv[, 1];
  q2  = sqrt(ee[2]) # vv[, 2];

  create plot var {"q1" "q2" "colnames"};
    append;
  close plot;
quit;

proc sgplot data = plot
    noautolegend;
  title 'Car Marks Data';
  scatter x = q1 y = q2 / markerattrs = (color = blue symbol = circlefilled)
    datalabel = colnames;
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'First Factor';
  yaxis label = 'Second Factor';
run;
