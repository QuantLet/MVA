
* Import the data;
data carc;
  infile '/folders/myfolders/Sas-work/data/carc_sas.txt';
  input t1 $ t2 $ t3 $ t4 $ t5 $ t6 $ t7 $ t8 $ t9 $ t10 $ t11 $ t12 $ t13 $;
  M = input(t2, 8.);
  W = input(t8, 8.);
  C = input(t13, 8.);
  drop t1--t13;
run;

proc sgplot data = carc
    noautolegend;
  title 'Car Data';
  scatter x = M y = W / colorresponse = C colormodel = (black red blue);
  xaxis label = 'Mileage (X2)';
  yaxis label = 'Weight (X8)';
run;
