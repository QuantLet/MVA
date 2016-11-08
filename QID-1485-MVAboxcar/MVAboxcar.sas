
* Import the data;
data carc;
  infile '/folders/myfolders/Sas-work/data/carc_sas.txt';
  input t1 $ t2 $ t3 $ t4 $ t5 $ t6 $ t7 $ t8 $ t9 $ t10 $ t11 $ t12 $ t13 $;
  M = input(t2, 8.);
  C = input(t13, 8.);
  drop t1--t13;
run;

data obs1;
  set carc;
  if C = 1;
  US = M;
  drop M C;
run;

data obs2;
  set carc;
  if C = 2;
  JAPAN = M;
  drop M C;
run;

data obs3;
  set carc;
  if C = 3;
  EU = M;
  drop M C;
run;

data carc;
  id + 1;
  merge obs1 obs2 obs3;
run;

proc transpose data = carc out = car_t;
  by id;
run;

data car_t;
  set car_t;
  label _name_ = "Variable";
  label col1 = "Value";
run;

title "Car Data";
proc sgplot data = car_t;
  vbox col1 / group = _name_ ;
run;

