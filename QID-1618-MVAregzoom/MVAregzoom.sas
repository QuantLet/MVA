
* Import the data;
data pull;
  infile '/folders/myfolders/Sas-work/data/pullover.dat';
  input x1-x4; 
  drop x3 x4;
run;

proc means data = pull noprint;
  var x1;
  output out = testmean mean = xbar;
run;

data _null_;
  set testmean;
  call symput("mx1",xbar);
run;

%put mean of x is &mx1;

* calculating mean;
%put mean x1 = &mx1;

* regression of (X1) sales on (X2) price;
ods graphics off;
proc reg data = pull;
  model x1 = x2;
  ods output ParameterEstimates=PE;
run;

proc iml;
  * Read data into a matrix;
  use pull;
    read all var _ALL_ into x; 
  close pull;
  
  use PE;
    read all var _ALL_ into z; 
  close PE;
  
  alpha = z[1,2];
  beta  = z[2,2];

  * generating lines;
  y = j(2*nrow(x),7,0);
  do i = 1 to nrow(x);
    y[2*i-1,1] = x[i,1];
    y[2*i-1,2] = x[i,2];
    y[2*i-1,3] = x[i,1];
    y[2*i-1,5] = &mx1;
    y[2*i-1,7] = i;
    y[2*i,1] = &mx1;
    y[2*i,2] = x[i,2];
    y[2*i,3] = alpha + beta*x[i,2];
    y[2*i,5] = alpha + beta*x[i,2];
    y[2*i,7] = i;
  end;

  y[,4] = y[,2]+0.3;
  y[,6] = y[,2]-0.3;
  
  create lines from y[colname={"b1" "b2" "r1" "r2" "g1" "g2" "id"}];
    append from y;
  close lines;
quit;

data pull;
  merge pull lines;
run;

* regression of (X1) sales on (X2) price;
proc sgplot data = pull noautolegend;
   title "Pullover Data";
   reg y = x1 x = x2 / 
     lineattrs = (color = purple thickness = 2) 
     markerattrs = (color = black); 
   series y = b1 x = b2 / group = id 
     lineattrs = (color = red pattern = 4 thickness = 2);                   * red line;
   series y = r1 x = r2 / group = id 
     lineattrs = (color = blue pattern = MediumDashShortDash thickness = 2);  * blue line;
   series y = g1 x = g2 / group = id 
     lineattrs = (color = green thickness = 2);                              * green line;
   refline &mx1 / lineattrs = (color = black pattern = 4 thickness = 2);
   xaxis min = 88  max = 102 label = 'Price (X2)';
   yaxis min = 162 max = 198 label = 'Sales (X1)';
run;
