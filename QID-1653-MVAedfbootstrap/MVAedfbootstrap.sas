proc iml;
  start Sorting(x,n);
    a   = (0:n - 1) / n;
    aa  = x[2:n] || a[2:n];
    bb  = x[1:n - 1] || a[2:n];
    cc  = aa // bb;
    call SORTNDX(idx1, cc, 1);
    call SORTNDX(idx2, cc, 2);
    edf = (cc[idx1, 1]) || (cc[idx2, 2]);
    end = nrow(cc);
    edf = (edf[1, 1] || {0}) // edf // (edf[end, 1] || {1});
    return(edf);
  finish;
  
  %let n = 100;
  n = &n; 
  x = randnormal(n, 0, 1);
  call sort(x, 1);
  edf = Sorting(x,n);
  
  * First bootstrap sample;
  xs1 = x[ceil(n * randfun(n, "Uniform"))];
  
  * Second bootstrap sample;
  xs2 = x[ceil(n * randfun(n, "Uniform"))];
  
  * Sorting the first sample;
  edfs1 = Sorting(xs1,n);
  
  * Sorting the second sample;
  edfs2 = Sorting(xs2,n);
  
  x11 = edf[, 1];
  x12 = edf[, 2];
  x21 = edfs1[, 1];
  x22 = edfs1[, 2];
  x31 = edfs2[, 1];
  x32 = edfs2[, 2];
  
  create plot var {"x11" "x12" "x21" "x22" "x31" "x32"};
    append;
  close plot; 
quit;

proc sgplot data = plot;
  title 'EDF and 2 bootstrap EDFs, n = '&n;
  series x = x11 y = x12 / lineattrs = (color = black THICKNESS = 2)
    legendlabel = "edf";
  series x = x21 y = x22 / lineattrs = (color = red THICKNESS = 2)
    legendlabel = "bootstrap edf 1";
  series x = x31 y = x32 / lineattrs = (color = blue THICKNESS = 2)
    legendlabel = "bootstrap edf 2";
  xaxis label = 'X';
  yaxis label = 'edfs';
run;
