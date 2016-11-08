
* Import the data;
data pull;
  infile '/folders/myfolders/Sas-work/data/pullover.dat';
  input x1-x4; 
  drop x3 x4;
run;

* regression of (X1) sales on (X2) price;
ods graphics on;
proc reg data = pull
    plots(only) = (fit(nocli stats=none));
  model x1 = x2;
run;
ods graphics off;
   
