
* Import the data;
data uscrime;
  infile '/folders/myfolders/data/uscrime_sas.dat';
  input temp1-temp11;
run;

proc iml;
  * Read data into a matrix;
  use uscrime;
    read all var _ALL_ into x; 
  close uscrime;
  
  x  = x[, 3:9];
  n1 = nrow(x);
  n2 = ncol(x);
  
  rows = x[,+];
  cols = x[+,];
  mat  = x[+,+];  
  D    = j(50, 50, 0);
  
  do i = 1 to n1 - 1;
    do j = i + 1 to n1;
      do z = 1 to n2;
         D[i, j] = 1/(cols[z]/mat) * ((x[i, z]/rows[i]) - (x[j, z]/rows[j])) ## 2;
      end;
    end;
  end;
  
  print D;
quit;