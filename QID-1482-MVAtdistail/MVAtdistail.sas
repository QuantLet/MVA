data pdf;
  do x1 = -6 to 6 by 0.02;
    y1 = pdf("Normal", x1);
    output;
  end;
  
  do x2 = -6 to 6 by 0.1;
    y2 = pdf("T", x2, 1);
    y3 = pdf("T", x2, 3);
    y4 = pdf("T", x2, 9);
    y5 = pdf("T", x2, 45);
    output;
  end;
run;
 
proc sgplot data = pdf;
  title 'Tail comparison of t-distribution';
  series x = x1 y = y1 / legendlabel = 'Gaussian' lineattrs = (color = grey thickness = 2);
  series x = x2 y = y2 / legendlabel = 't1'  lineattrs = (color = black thickness = 2);
  series x = x2 y = y3 / legendlabel = 't3'  lineattrs = (color = blue thickness = 2);
  series x = x2 y = y4 / legendlabel = 't9'  lineattrs = (color = red thickness = 2);
  series x = x2 y = y5 / legendlabel = 't45' lineattrs = (color = purple thickness = 2);
  xaxis min = 2.5 max = 4    label = "X"; 
  yaxis min = 0   max = 0.04 label = "Y";
run;