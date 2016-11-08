
* Import the data;
data carmean2;
  infile '/folders/myfolders/data/carmean2_sas.dat';
  input t0 $ t1-t8;
run;
  
proc distance data = carmean2 out = dist method = sqeuclid nostd;
   var interval(t1--t8);
run;

proc iml;
  * Read data into a matrix;
  use carmean2;
    read all var _ALL_ into x; 
  close carmean2;
  
  use dist;
    read all var _ALL_ into y; 
  close dist;
  
  colnames = {"economic", "service", "value", "price", "look", "sporty", "security", 
    "easy"}; 
  rownames = {"Audi", "BMW", "Citroen", "Ferrari", "Fiat", "Ford", "Hyundai", 
    "Jaguar", "Lada", "Mazda", "Mercedes", "Mitsubishi", "Nissan", "Opel Corsa", 
    "Opel Vectra", "Peugeot", "Renault", "Rover", "Toyota", "Trabant", "VW Golf", 
    "VW Passat", "Wartburg"};
  
  n = nrow(y);
  do i = 1 to n;
    do j = i + 1 to n;
      y[i,j] = y[j,i];
    end;
  end;
  
  d = y[:,];                            * mean for every row of the distance matrix;
  B = 0.5 * ((y - d)` - d + d[:,:]);    * inner product matrix;
  
  * spectral decomposition;
  eva = eigval(B);
  eve = eigvec(B)[, 1:2];
  sq = repeat (sqrt(eva[1:2])`, nrow(eva), 1);
  
  * the coordinate matrix which contains the point configuration;
  q = eve # sq;
  corr = corr(q || x);
  
  r = corr[3:ncol(corr), 1:2];          * extract the first two principal components;
  
  x1 = q[,1];
  x2 = q[,2];
  y1 = r[,1];
  y2 = r[,2];
  
  pi = constant("pi");
  uc = (cos((0:360)/180 * pi) // sin((0:360)/180 * pi))`;
  u1 = uc[,1];
  u2 = uc[,2];
  
  create plot var {"x1" "x2" "u1" "u2" "y1" "y2" "rownames" "colnames"};
    append;
  close plot;
quit;
    
* Plot for the MDS solution on the car data;
proc sgplot data = plot
    noautolegend;
  title 'Metric MDS';
  scatter x = x1 y = x2 / markerattrs = (symbol = circlefilled)
    datalabel = rownames;
  xaxis label = 'x';
  yaxis label = 'y';
run;

* Plot for the correlation between the MDS direction and the variables;
proc sgplot data = plot
    noautolegend;
  title 'Correlations MDS/Variables';
  series  x = u1 y = u2 / lineattrs = (color = blue THICKNESS = 2);
  scatter x = y1 y = y2 / markerattrs = (color = black symbol = circlefilled)
    datalabel = colnames;
  xaxis label = 'x';
  yaxis label = 'y';
run;

