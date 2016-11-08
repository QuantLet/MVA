
* Import the data;
data cities;
  id + 1;
  infile '/folders/myfolders/Sas-work/data/cities.txt';
  input World_Cities;
run;

proc transpose data = cities out = cities_t;
  by id;
run;

data cities_t;
  set cities_t;
  label _name_ = "Variable";
  label col1 = "Value";
run;

title "Boxplot";
proc sgplot data = cities_t;
  vbox col1 / group = _name_ ;
run;

title 'Five number summary';
proc means data = cities p5 p25 p50 p75 p95;
  var World_Cities;
run;