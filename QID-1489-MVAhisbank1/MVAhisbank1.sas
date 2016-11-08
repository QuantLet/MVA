
* Import the data;
data bank2;
  infile '/folders/myfolders/Sas-work/data/bank2.dat';
  input t1-t6;
  drop t1-t5;
run;

data b2;
  set bank2 (firstobs = 101 obs = 200);
run;

* Because origin=137.75<min(x), the histogram includes all values;
title 'Swiss Bank Notes';
proc univariate data = b2 noprint;
  histogram t6 / 
    odstitle = 'h = 0.1'
    endpoints = 137.75 to 141.05 by 0.1;
  histogram t6 / 
    odstitle = 'h = 0.2'
    endpoints = 137.75 to 141.05 by 0.2;
  histogram t6 / 
    odstitle = 'h = 0.3'
    endpoints = 137.75 to 141.05 by 0.3;
  histogram t6 / 
    odstitle = 'h = 0.4'
    endpoints = 137.75 to 141.05 by 0.4;
run;




