proc iml;
  start ChiSq(r, c, x);
    x = shape(x, r, c);
    rowst = x[,+];
    colst = x[+,];
    n = x[+,+];
    
    * Expected values under independence;
    E = j(r, c, 0);
    do i = 0 to r-1;
      do j = 0 to c-1;
        E[i + 1,j + 1] = rowst[i + 1] * colst[j + 1] / n;
      end;
    end;
    
    Chi = ((E - x) ## 2 / E)[+,+];
    return(Chi);
  finish;
  
  * Data (eye color vs. hair color, r = number of rows, c = number of columns);
  r = 4;
  c = 4;
  X = {68, 119, 26, 7, 15, 54, 14, 10, 5, 29, 14, 16, 20, 84, 17, 94};
  
  * Chi-Square test statistic;
  Chi2 = ChiSq(r, c, X);
  print Chi2;
quit;