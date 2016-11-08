
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAincomeLi** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVAincomeLi

Published in : Applied Multivariate Statistical Analysis

Description : Hexagon plot between Income and Flat size.

Keywords : plot, graphical representation, hexagon-plot, data visualization, financial, sas

See also : MVAageCom, MVAageIncome

Author : Vinh Hanh Lieu

Author[SAS] : Svetlana Bykovskaya

Submitted : Thu, August 04 2011 by Awdesch Melzer

Submitted[SAS] : Wen, April 6 2016 by Svetlana Bykovskaya

Datafile : allbus.csv

```

![Picture1](MVAincomeLi.jpg)

![Picture2](MVAincomeLi_sas.png)


### R Code:
```r

# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# install and load packages
libraries = c("hexbin")
lapply(libraries, function(x) if (!(x %in% installed.packages())) {
    install.packages(x)
})
lapply(libraries, library, quietly = TRUE, character.only = TRUE)

# load data
allbus  = read.csv2("allbus.csv")
allbus7 = allbus[, c(3, 8)]

# exclude unvalid observations
allbus7       = allbus7[(allbus7$NETTOEIN < 99997) & (allbus7$WOHNFLAE < 998), ]
living_space  = allbus7[, 2]
netincome     = allbus7[, 1]

# hexagon plot
hexbinplot(living_space ~ netincome, main="Hexagon plot", xlab = "Income", ylab = "Flat Size", style = "colorscale", 
    border = TRUE, aspect = 1, trans = sqrt, inv = function(netincome) netincome^2)

```

### SAS Code:
```sas

* Import the data;
data allbus;
  infile '/folders/myfolders/Sas-work/data/allbus.csv' dlm=';' dsd firstobs=2;
  input t1 $ t2 $ t3 $ t4 $ t5 $ t6 $ t7 $ t8 $ t9 $ t10 $ ;
  drop t1-t2 t4-t7 t9-t10;
  
run;

proc iml;
  * Read data into a matrix;
  use allbus;
    read all var _ALL_ into x; 
  close allbus;
  
  x = num(x);
  
  create datax from x[colname={"netincome" "living_space"}];
    append from x;
  close datax;
quit;

* Exclude unvalid observations;
data new;
  set datax;
  if (netincome < 99997 & living_space < 998);
run;

%macro HexBin(dsName, xName, yName, xlab, ylab, nBins=36, colorramp=TwoColorRamp);
  ods select none;
  ods output fitplot=_HexMap;  /* write graph data to a data set */
  proc surveyreg data=&dsname plots(nbins=&nBins weight=heatmap)=fit(shape=hex);
    model &yName = &xName;
  run;
  ods select all;
 
  proc sgplot data=_HexMap;
    polygon x=XVar y=YVar ID=hID / colorresponse=WVar fill 
                                    colormodel=&colorramp;
    xaxis label = &xlab;
    yaxis label = &ylab;
  run;
%mend;

title 'Hexagon plot';
%HexBin(new, netincome, living_space, 'Income', 'Flat Size');

```
