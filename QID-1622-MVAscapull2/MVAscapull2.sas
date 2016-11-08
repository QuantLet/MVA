
* Import the data;
data pull;
  infile '/folders/myfolders/Sas-work/data/pullover.dat';
  input x1-x4; 
run;

proc sgplot data = pull
    noautolegend;
  title 'Pullovers Data';
  scatter x = x4 y = x1 / markerattrs = (color = blue);
  xaxis min = 70 max = 120 label = 'Sales Assistants (X4)';
  yaxis min = 80 max = 240 label = 'Sales (X1)';
run;