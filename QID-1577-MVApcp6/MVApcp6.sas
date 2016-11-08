
* Import the data;
data carc;
  id + 1;
  infile '/folders/myfolders/data/carc_sas.txt';
  input t1 $ t2 $ t3 $ t4 $ t5 $ t6 $ t7 $ t8 $ t9 $ t10 $ t11 $ t12 $ t13 $;
  headroom    = input(t5, 8.);
  rear_seat   = input(t6, 8.);
  trunk_space = input(t7, 8.);
  drop t1--t13;
run;

proc transpose data = carc out = car_t;
  by id;
run;

data car_t;
  set car_t;
  label _name_ = "Variable";
  label col1 = "Value";
run;

title "Boxplot (Car Data)";
proc sgplot data = car_t;
  vbox col1 / group = _name_ ;
run;