
* Import the data;
data journaux;
  infile '/folders/myfolders/data/journaux.dat';
  input temp1-temp10;
run;

proc iml;
  * Read data into a matrix;
  use journaux;
    read all var _ALL_ into x; 
  close journaux;
  
  a = x[,+];
  b = x[+,];
  e = a * b / sum(a);
  
  * chi-matrix;
  cc = (x - e)/sqrt(e);
  
  * singular value decomposition;
  call svd(u,q,v,cc);
  
  * eigenvalues;
  qq = q # q;
  
  * cumulated percentage of the variance;
  aux  = cusum(qq)/sum(qq);
  perc = qq || aux;
  r1   = repeat(q`, nrow(u), 1) # u;
  r    = r1 / repeat(sqrt(a), 1, ncol(u));
  s1   = repeat(q`, nrow(v), 1) # v;
  s    = s1 / repeat(sqrt(b)`, 1, ncol(v));
  
  * contribution in r;
  car = repeat(a, 1, ncol(r)) # (r ## 2) / repeat((q ## 2)`, nrow(r), 1);
  
  * contribution in s;
  cas = repeat(b`, 1, ncol(s)) # (s ## 2) / repeat((q ## 2)`, nrow(s), 1);
  
  rr = r[, 1:2];
  ss = s[, 1:2];
  
  types = {"va", "vb", "vc", "vd", "ve", "ff", "fg", "fh", 
    "fi", "bj", "bk", "bl", "vm", "fn", "fo"};   * labels for journals;
  regions = {"brw", "bxl", "anv", "brf", "foc", "for", 
    "hai", "lig", "lim", "lux"};                 * labels for regions;
  
  x1  = rr[,1];
  x2  = -rr[,2]; 
  x3  = ss[,1];
  x4  = -ss[,2]; 
      
  create plot var {"x1" "x2" "x3" "x4" "types" "regions"};
    append;
  close plot;
quit;

proc sgplot data = plot
    noautolegend;
  title 'Journal Data';
  scatter x = x1 y = x2 / markerattrs = (color = blue symbol = circlefilled)
    datalabel = types;
  scatter x = x3 y = x4 / markerattrs = (color = red symbol = circlefilled)
    datalabel = regions;
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'r_1,s_1';
  yaxis label = 'r_2,s_2';
run;