proc iml;
  x   = {3, 2, 1, 10} || {2, 7, 3, 4};
  d   = distance(x);
  
  f1  = {1} || d[2, 3];
  f2  = {2} || d[1, 3];
  f3  = {3} || d[1, 2];
  f4  = {4} || d[2, 4];
  f5  = {5} || d[1, 4];
  f6  = {6} || d[3, 4];
  fig = f1 // f2 // f3 // f4 // f5 // f6;
  
  x1  = fig[,1];
  x2  = fig[,2];
  points = {'(2,3)', '(1,3)', '(1,2)', '(2,4)', '(1,4)', '(3,4)'};
	
  create plot var {"x1" "x2" "points"};
    append;
  close plot;
quit;

proc sgplot data = plot
    noautolegend;
  title 'Dissimilarities and Distances';
  scatter x = x1 y = x2 / datalabel = points 
    datalabelattrs = (color = red) datalabelpos = right
    markerattrs = (symbol = squarefilled);
  series  x = x1 y = x2 / lineattrs = (color = black THICKNESS = 2);
  xaxis min = 0 max = 7  label = 'Dissimilarity';
  yaxis min = 0 max = 10 label = 'Distance'; 
run;
  