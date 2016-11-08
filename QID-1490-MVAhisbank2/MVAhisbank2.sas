
* Import the data;
data bank2;
  infile '/folders/myfolders/Sas-work/data/bank2.dat';
  input t1-t6;
  drop t1-t5;
run;

data b2;
  set bank2 (firstobs = 101 obs = 200);
run;
  
title 'Swiss Bank Notes';
proc univariate data = b2 noprint;
  histogram t6 / 
    odstitle = 'x_0 = 137.65'
    endpoints = 137.65 to 141.05 by 0.4;
  histogram t6 / 
    odstitle = 'x_0 = 137.75'
    endpoints = 137.75 to 141.05 by 0.4;
  histogram t6 / 
    odstitle = 'x_0 = 137.85'
    endpoints = 137.45 to 141.05 by 0.4; * origin>min(x);
  histogram t6 / 
    odstitle = 'x_0 = 137.95'
    endpoints = 137.55 to 141.05 by 0.4; * origin>min(x);
run;
