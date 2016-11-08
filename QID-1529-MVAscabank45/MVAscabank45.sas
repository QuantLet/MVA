
* Import the data;
data bank2;
  infile '/folders/myfolders/Sas-work/data/bank2.dat';
  input x1-x6;
run;

proc sgplot data = bank2
    noautolegend;
  title 'Swiss bank notes';
  scatter x = x4 y = x5 / markerattrs = (color = blue);
  xaxis min = 7 max = 13;
  yaxis min = 7 max = 13;
run;