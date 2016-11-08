
* Import the data;
data b2;
  id + 1;
  infile '/folders/myfolders/Sas-work/data/bank2.dat';
  input x1-x6;
  drop x1-x5;
run;

data obs1;
  set b2 (firstobs = 1 obs = 100);
  GENUINE = x6;
  drop x6;
run;

data obs2;
  set b2 (firstobs = 101 obs = 200);
  COUNTERFEIT = x6;
  drop x6;
run;

data b2;
  merge obs1 obs2;
run;

proc transpose data = b2 out = b2_t;
  by id;
run;

data b2_t;
  set b2_t;
  label _name_ = "Variable";
  label col1 = "Value";
run;

title "Swiss Bank Notes";
proc sgplot data = b2_t;
  vbox col1 / group = _name_ ;
run;