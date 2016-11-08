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
  
  * Data (X3 vs. X4, r = number of rows, c = number of columns);
  r = 5;
  c = 5;
  X3X4 = {1, 1, 0, 0, 0, 0, 7, 1, 0, 0, 2, 2, 19, 5, 0, 0, 0, 6, 11, 0, 0, 1, 1, 4, 5};
  Chi2_X3X4 = ChiSq(r, c, X3X4); * * Chi-Square test statistic (X3 vs. X4);
  
  * Data (X3 vs. X13, r = number of rows, c = number of columns);
  r = 5;
  c = 3;
  X3X13 = {2, 0, 0, 8, 0, 0, 26, 0, 2, 8, 5, 4, 2, 6, 3};
  Chi2_X3X13 = ChiSq(r, c, X3X13); * Chi-Square test statistic (X3 vs. X13);
  
  * Data (X4 vs. X13, r = number of rows, c = number of columns);
  r = 5;
  c = 3;
  X4X13 = {2, 0, 1, 10, 0, 1, 21, 1, 5, 13, 5, 2, 0, 5, 0};
  Chi2_X4X13 = ChiSq(r, c, X4X13); * Chi-Square test statistic (X4 vs. X13);
  
  * Chi-Square test statistics;
  Chi2 = Chi2_X3X4 || Chi2_X3X13 || Chi2_X4X13;
  print Chi2;
quit;

