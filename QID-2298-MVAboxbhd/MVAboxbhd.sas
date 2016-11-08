* Import the data;
data bostonh;
  infile '/folders/myfolders/Sas-work/data/bostonh.dat';
  input temp1-temp14;
run;

proc iml;
  * Read data into a matrix;
  use bostonh;
    read all var _ALL_ into x; 
  close bostonh;
  
  zz = x;
  do i = 1 to ncol(x);
     zz[, i] = (x[, i] - mean(x[, i]))/(sqrt(var(x[, i])));
  end;
  zz = (1:nrow(x))` || zz ;
  
  xt = x;
  xt[, 1]  = log(x[, 1]);
  xt[, 5]  = log(x[, 5]);
  xt[, 6]  = log(x[, 6]);
  xt[, 7]  = (x[, 7] ## (2.5))/10000;
  xt[, 8]  = log(x[, 8]);
  xt[, 9]  = log(x[, 9]);
  xt[, 10] = log(x[, 10]);
  xt[, 11] = exp(0.4 * x[, 11])/1000;
  xt[, 13] = sqrt(x[, 13]);
  xt[, 14] = log(x[, 14]);
  
  tt = x;
   do i = 1 to ncol(x);
     tt[, i] = (xt[, i] - mean(xt[, i]))/(sqrt(var(xt[, i])));
  end;
  tt = (1:nrow(x))` || tt ;
  
  create dat1 from zz[colname={"id" "t1" "t2" "t3" "t4" "t5" "t6" "t7" "t8" "t9" "t10" "t11" "t12" "t13" "t14"}];
    append from zz;
  close dat1;
  
  create dat2 from tt[colname={"id" "t1" "t2" "t3" "t4" "t5" "t6" "t7" "t8" "t9" "t10" "t11" "t12" "t13" "t14"}];
    append from tt;
  close dat2;  
quit;

* Boston Housing data;
proc transpose data = dat1 out = dat1_t;
  by id;
run;

data dat1_t;
  set dat1_t;
  label _name_ = "Variable";
  label col1 = "Value";
run;

title "Boston Housing data";
proc sgplot data = dat1_t;
  vbox col1 / group = _name_ ;
run;

*Transformed Boston Housing data;
proc transpose data = dat2 out = dat2_t;
  by id;
run;

data dat2_t;
  set dat2_t;
  label _name_ = "Variable";
  label col1 = "Value";
run;

title "Transformed Boston Housing data";
proc sgplot data = dat2_t;
  vbox col1 / group = _name_ ;
run;