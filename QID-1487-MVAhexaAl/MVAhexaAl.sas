proc iml;
  * create vector;
  start RepV(a,c);
    do i = 1 to ncol(c);
      res = res || repeat(c[i], 1, ncol(a));
    end;
  return(res);
  finish;
  
  * create blue and black points;
  a = (-sqrt(3)) || {0} || sqrt(3);
  blue = RepV(a,-2:2);
  b = (-sqrt(3)/2) || (sqrt(3)/2) || (3 * sqrt(3)/2);
  black = RepV(b,-1.5:2.5);
  point1 = repeat(a, 1, ncol(blue)/ncol(a));
  point2 = repeat(b, 1, ncol(black)/ncol(b));
  red1 = -0.2;
  red2 = 0.2;
  
  co1 = sqrt(3)/2 - 1/sqrt(3);
  co2 = sqrt(3)/2 - 1/(2 * sqrt(3));
  co3 = sqrt(3)/2 + 1/(2 * sqrt(3));
  co4 = sqrt(3)/2 + 1/sqrt(3);
  co5 = -1/sqrt(3);
  co6 = -1/(2 * sqrt(3));
  
  * coordinates of blue rectangle, black rectangle, 
  green hexagon and yellow hexagon;
  rec1 = {-1,   -1,    0,    0, 
        -0.5, -0.5,  0.5,  0.5, 
        -0.5,   -1,   -1, -0.5,   0,   0, 
           0, -0.5, -0.5,    0, 0.5, 0.5}`;
  rec2 = {0}     || sqrt(3)   || sqrt(3)   || {0}          ||
    (-sqrt(3)/2) || sqrt(3)/2 || sqrt(3)/2 || (-sqrt(3)/2) ||
    co1 || co2 || co3 || co4 || co3 || co2 ||
    co5 || co6 || co1 || co2 || co1 || co6;
  id = repeat({1}, 1, 4) || repeat({2}, 1, 4) || 
       repeat({3}, 1, 6) || repeat({4}, 1, 6);

  create plot var {"blue" "black" "red1" "red2" "point1" "point2"
    "rec1" "rec2" "id"};
    append;
  close plot;
quit;

proc sgplot data = plot
    noautolegend;
  title 'Hexagon Algorithm';
  scatter x = blue  y = point1 / markerattrs = (color = blue);
  scatter x = black y = point2 / markerattrs = (color = black);
  scatter x = red1 y = red2 / markerattrs = (color = red);
  polygon x = rec1 y = rec2 id = id / 
    colorresponse = id colormodel = (blue black green yellow)
    lineattrs = (thickness = 2);
  xaxis min = -2 max = 2 label = 'X';
  yaxis min = -2 max = 3 label = 'Y';
run;
