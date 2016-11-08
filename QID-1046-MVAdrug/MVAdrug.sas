proc iml;
  * Specifics of the dataset;
  Q = 3;  * number of variables;
  I = 2;  * sex M - F;
  J = 2;  * drug Yes - No;
  K = 5;  * age category 16-29, 30-44, 45-64, 65-74, 75++;
  
  * Truncated dataset with first observations missing;
  zi = ({1, 0, 1, 0, 1, 0, 0, 0, 0, 21} ||
    {1, 0, 1, 0, 0, 1, 0, 0, 0, 32 } ||
    {1, 0, 1, 0, 0, 0, 1, 0, 0, 70 } || 
    {1, 0, 1, 0, 0, 0, 0, 1, 0, 43 } ||
    {1, 0, 1, 0, 0, 0, 0, 0, 1, 19 } || 
    {1, 0, 0, 1, 1, 0, 0, 0, 0, 683} ||
    {1, 0, 0, 1, 0, 1, 0, 0, 0, 596} ||
    {1, 0, 0, 1, 0, 0, 1, 0, 0, 705} ||
    {1, 0, 0, 1, 0, 0, 0, 1, 0, 295} ||
    {1, 0, 0, 1, 0, 0, 0, 0, 1, 99 } || 
    {0, 1, 1, 0, 1, 0, 0, 0, 0, 46 } || 
    {0, 1, 1, 0, 0, 1, 0, 0, 0, 89 } || 
    {0, 1, 1, 0, 0, 0, 1, 0, 0, 169} ||
    {0, 1, 1, 0, 0, 0, 0, 1, 0, 98 } || 
    {0, 1, 1, 0, 0, 0, 0, 0, 1, 51 } || 
    {0, 1, 0, 1, 1, 0, 0, 0, 0, 738} || 
    {0, 1, 0, 1, 0, 1, 0, 0, 0, 700} || 
    {0, 1, 0, 1, 0, 0, 1, 0, 0, 847} ||
    {0, 1, 0, 1, 0, 0, 0, 1, 0, 336} || 
    {0, 1, 0, 1, 0, 0, 0, 0, 1, 196})`;
    
  * namind = {'my1','my2','my3','my4','my5',
    'mn1','mn2','mn3','mn4','mn5',
    'fy1','fy2','fy3','fy4','fy5',
    'fn1','fn2','fn3','fn4','fn5'};
  * namvar = {'M','F','DY','DN','A1','A2','A3','A4','A5'}; * name of columns;
  
  * Read the relevant data;
  men    = zi[1:5, 10] || zi[6:10, 10];
  women  = zi[11:15, 10] || zi[16:20, 10];
  a      = (men[, 1] // men[, 2] // women[, 1] // women[, 2])`;
  age    = repeat({'A1' 'A2' 'A3' 'A4' 'A5'}, 1, 4);
  t      = repeat({'DY'}, 1, 5) || repeat({'DN'}, 1, 5);
  drug   = t || t;
  mgen   = repeat({'men'}, 1, 10);
  wgen   = repeat({'women'}, 1, 10);
  gender = mgen || wgen;
	
  create gendertable var {"a" "drug" "age" "gender"};
    append;
  close gendertable;
quit;
  
proc freq data = gendertable;
  tables gender*drug*age / nocol norow nopercent;
  weight a;
run;
  

