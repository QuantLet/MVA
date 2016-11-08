proc iml;
  x  = {3, 2, 1, 10} || {2, 7, 3, 4};
  
  x1 = x[,1];
  x2 = x[,2];
  cars = {'Mercedes', 'Jaguar', 'Ferrari', 'VW'};
	
  create plot var {"x1" "x2" "cars"};
    append;
  close plot;
quit;

proc sgplot data = plot;
  title 'Initial Configuration';
  scatter x = x1 y = x2 / datalabel = cars datalabelpos = right;
  xaxis min = 0 max = 12 display = (nolabel);
  yaxis min = 0 max = 8  display = (nolabel); 
run;