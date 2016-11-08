proc iml;
  x  = ({3, 2} || {2, 7} || {1, 3} || {0.37, 4.36} || {10, 4})`;
  l  = (x[3, 1] // x[4, 1]) || (x[3, 2] // x[4, 2]);
  
  x1 = x[,1];
  x2 = x[,2];
  x3 = l[,1];
  x4 = l[,2];
  points = {'Mercedes', 'Jaguar', 'Ferrari Init', 'Ferrari New', 'VW'};
  
  create plot var {"x1" "x2" "x3" "x4" "points"};
    append;
  close plot;
quit;

proc sgplot data = plot
    noautolegend;
  title 'First iteration for Ferrari';
  scatter x = x1 y = x2 / datalabel = points 
    datalabelattrs = (color = red) datalabelpos = right
    markerattrs = (symbol = circlefilled color = red);
  series x = x3 y = x4 / lineattrs = (color = red THICKNESS = 2);
  xaxis min = 0 max = 12 display = (nolabel);
  yaxis min = 0 max = 8  display = (nolabel); 
run;

