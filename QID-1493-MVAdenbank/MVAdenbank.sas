
* Import the data;
data bank2;
  infile '/folders/myfolders/Sas-work/data/bank2.dat';
  input t1-t6;
  drop t1-t5;
run;

proc iml;
  * Read data into a matrix;
  use bank2;
    read all var _ALL_ into x; 
  close bank2;
  
  x1 = x[1:100];
  x2 = x[101:200];
  
  create plot var {"x1" "x2"};
    append;
  close plot;
quit;

ods graphics on;

proc kde data = plot;
  title 'Swiss bank notes';
  univar x1 x2/ plots = (densityoverlay) noprint;
run;

ods graphics off;
