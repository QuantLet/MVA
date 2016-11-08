
* Import the data;
data b2;
  infile '/folders/myfolders/Sas-work/data/bank2.dat';
  input x1-x6; 
  drop x1 x2 x3 x6;
run;

data b2;
  set b2 (firstobs = 1 obs = 100);
run;

* regression of (X5) on (X4) price;
ods graphics on;
proc reg data = b2
    plots(only) = (fit(nocli stats=none));
  model x5 = x4;
run;
ods graphics off;
   

