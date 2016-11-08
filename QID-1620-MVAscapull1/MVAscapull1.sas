
* Import the data;
data pull;
  infile '/folders/myfolders/Sas-work/data/pullover.dat';
  input x1-x4; 
run;

proc sgplot data = pull
    noautolegend;
  title 'Pullovers Data';
  scatter x = x2 y = x1 / markerattrs = (color = blue);
  xaxis min = 78 max = 127 label = 'Price (X2)';
  yaxis min = 80 max = 240 label = 'Sales (X1)';
run;