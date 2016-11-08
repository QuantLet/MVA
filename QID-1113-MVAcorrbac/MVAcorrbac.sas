
* Import the data;
data bac;
  infile '/folders/myfolders/data/bac.dat';
  input temp1 $ temp2-temp9;
run;

proc iml;
  * Read data into a matrix;
  use bac;
    read all var _ALL_ into x; 
  close bac;
  
  n1 = nrow(x);
  wcors = 0;   * set to 0/1 to ex/include Corsica;
  if (wcors = 0) then x = x[1:n1-1,];
  
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
  
  types = {"A", "B", "C", "D", "E", "F", "G", "H"};   * labels for modalities;
  regions = {"ildf", "cham", "pica", "hnor", "cent", "bnor", "bour", "nopc", 
        "lorr", "alsa", "frac", "payl", "bret", "pcha", "aqui", "midi", "limo", "rhoa", 
        "auve", "laro", "prov"};                      * labels for regions;
        
  if (wcors = 1) then regions = regions // {"cors"};
  
  x1  = -rr[,1];
  x2  = rr[,2]; 
  x3  = -ss[,1];
  x4  = ss[,2];
      
  if (wcors = 1) then
    do;
      x1  = -x1;
      x2  = -x2; 
      x3  = -x3;
      x4  = -x4;
    end;
       
  create plot var {"x1" "x2" "x3" "x4" "types" "regions"};
    append;
  close plot;
quit;
  
proc sgplot data = plot
    noautolegend;
  title 'Baccalaureat Data';
  scatter x = x1 y = x2 / markerattrs = (color = blue symbol = circlefilled)
    datalabel = regions;
  scatter x = x3 y = x4 / markerattrs = (color = red symbol = circlefilled)
    datalabel = types;
  refline 0 / lineattrs = (color = black);
  refline 0 / axis = x lineattrs = (color = black);
  xaxis label = 'r_1,s_1';
  yaxis label = 'r_2,s_2';
run;
  
  
  
