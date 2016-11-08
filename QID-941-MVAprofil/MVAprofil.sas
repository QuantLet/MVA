proc iml;
  x  = (1:5)`;
  y1 = {2, 3, 4, 2.8, 3};  * Define group 1;
  y2 = {1.5, 2, 1.5, 2, 2.2}; * Define group 2;
	
  create plot var {"x" "y1" "y2"};
    append;
  close plot;
quit;

data plot;
  set plot;
  title 'Population Profiles';

  proc sgplot data = plot;
    series x = x y = y1 / lineattrs = (color = red THICKNESS = 2) 
      legendlabel = "Group 1";
    series x = x y = y2 / lineattrs = (pattern = 4 color = blue THICKNESS = 2)
      legendlabel = "Group 2";
    xaxis min = 1 max = 5 label = 'Treatment';
    yaxis min = 1 max = 5 label = 'Mean';
  run;
quit;
  