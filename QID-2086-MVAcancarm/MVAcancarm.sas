
* Import the data;
data carmean2;
  infile '/folders/myfolders/data/carmean2_sas.dat';
  input temp1 $ temp2-temp9;
run;

proc iml;
  * Read data into a matrix;
  use carmean2;
    read all var _ALL_ into x; 
  close carmean2;
  
  colnames = {"economy", "service", "value", "price", "design", "sporty", "safety", 
    "handling"}; 
  rownames = {"Audi", "BMW", "Citroen", "Ferrari", "Fiat", "Ford", "Hyundai", 
    "Jaguar", "Lada", "Mazda", "Mercedes", "Mitsubishi", "Nissan", "Opel Corsa", 
    "Opel Vectra", "Peugeot", "Renault", "Rover", "Toyota", "Trabant", "VW Golf", 
    "VW Passat", "Wartburg"};
  
  * reordering the columns of the matrix;
  cars = x[, 4:3] || x[, 1:2] || x[, 5:8];
  s    = cov(cars);
  sa   = s[1:2, 1:2];
  sb   = s[3:8, 3:8];
  sa2  = eigvec(sa) * diag(1/sqrt(eigval(sa))) * eigvec(sa)`;
  sb2  = eigvec(sb) * diag(1/sqrt(eigval(sb))) * eigvec(sb)`;
  k    = sa2 * s[1:2, 3:8] * sb2;
  
  call svd(u,q,v,k);
  a    = sa2 * u;
  b    = sb2 * v;
  eta  = cars[, 1:2] * a[, 1];
  phi  = cars[, 3:8] * b[, 1];
  
  create plot var {"eta" "phi" "rownames"};
    append;
  close plot;
quit;

proc sgplot data = plot
    noautolegend;
  title 'Car Marks Data';
  scatter x = eta y = phi / markerattrs = (color = blue symbol = circlefilled)
    datalabel = rownames;
  xaxis label = 'Eta 1';
  yaxis label = 'Phi 1';
run;
