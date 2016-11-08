
* Import the data;
data bank2;
  id + 1;
  infile '/folders/myfolders/Sas-work/data/bank2.dat';
  input x1-x6;
run;

data b2;
  set bank2;
   if id <= 100 then group = 1;
   else group = 2;
run;

proc sgplot data = b2
    noautolegend;
  title 'Swiss bank notes';
  scatter x = x5 y = x6 / colorresponse = group colormodel = (blue red);
  xaxis min = 7 max = 13;
  yaxis min = 137.5 max = 142.5;
run;