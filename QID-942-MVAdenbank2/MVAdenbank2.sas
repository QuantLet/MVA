
* Import the data;
data bank2;
  infile '/folders/myfolders/data/bank2.dat';
  input temp1-temp6;
run;

proc iml;
  * Read data into a matrix;
  use bank2;
    read all var _ALL_ into x; 
  close bank2;
  
  x4 = x[1:100, 4];
  x5 = x[1:100, 5];
  
  create plot var {"x4" "x5"};
    append;
  close plot;
quit;

ods graphics on;

proc kde data = plot;
  title 'Swiss bank notes';
  univar x4 / plots = (densityoverlay) noprint;
  univar x5 / plots = (densityoverlay) noprint;
run;

ods graphics off;
