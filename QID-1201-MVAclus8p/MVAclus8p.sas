
proc iml;
  * create matrix from 8 data points and define eight points;
  eight = {-3, -2, -2, -2, 1, 1, 2, 4} || {0, 4, -1, -2, 4, 2, -4, -3};
  eight = eight[{8, 7, 3, 1, 4, 2, 6, 5}, ];
  
  id = 1:8;
  w  = eight;
  z  = w[1,] // w[2,] // w[5,] // w[3,] // w[4,] // w[3,] //w[7,] // w[8,] // w[6,];
  
  x1 = w[,1];
  x2 = w[,2];
  x3 = z[,1];
  x4 = z[,2];
  
  create plot var {"x1" "x2" "x3" "x4" "id"};
    append;
  close plot;
quit;

proc sgplot data = plot
    noautolegend;
  title '8 points';
  scatter x = x1 y = x2 / markerattrs = (symbol = circlefilled color = red)
    datalabel = id;
  series x = x3 y = x4 / 
    lineattrs = (color = black THICKNESS = 2);
  xaxis label = 'price conciousness';
  yaxis label = 'brand loyalty';
run;

proc distance data = plot(obs = 8) out = dist method = sqeuclid nostd;
   var interval(x1 x2);
run;

data newdist;
  set dist;
  set plot;
  drop x1 x2 x3 x4;
run;

ods graphics on;
proc cluster data = newdist(type = distance)
    method = single
    plots(only) = (Pseudo Dendrogram(vertical))
    print = 0;
  id id;
run;
ods graphics off;

