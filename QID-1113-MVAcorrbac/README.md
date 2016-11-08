
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **MVAcorrbac** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of QuantLet : MVAcorrbac

Published in : Applied Multivariate Statistical Analysis

Description : 'Performs a correspondence analysis for the baccalaureat data, shows the eigenvalues
of the singular value decomposition of the chi-matrix and displays graphically its factorial
decomposition.'

Keywords : 'correspondence-analysis, svd, decomposition, factorial-decomposition, eigenvalues,
factorial, plot, graphical representation, data visualization, sas'

See also : 'MVAcorrCar, MVAcorrEyeHair, MVAcorrcrime, MVAcorrjourn, SMScorrcrime, SMScorrcarm,
SMScorrfood, SMScorrhealth'

Author : Zografia Anastasiadou

Author[SAS] : Svetlana Bykovskaya

Submitted : Fri, June 03 2011 by Zografia Anastasiadou

Submitted[SAS] : Wen, April 6 2016 by Svetlana Bykovskaya

Datafile : bac.dat

Example: 
- 1: Without Corsica
- 2: With Corsica

```

![Picture1](MVAcorrbac-1_sas.png)

![Picture2](MVAcorrbac-2_sas.png)

![Picture3](MVAcorrbac_1.png)

![Picture4](MVAcorrbac_2.png)


### R Code:
```r

# clear all variables
rm(list = ls(all = TRUE))
graphics.off()

# load data
x1       = read.table("bac.dat")
x1       = x1[, 2:ncol(x1)]
wcors    = 0                   # set to 0/1 to ex/include Corsica
wcorsica = c(rep(1, nrow(x1) - 1), wcors)
x        = subset(x1, wcorsica == 1)
a        = rowSums(x)
b        = colSums(x)
e        = matrix(a) %*% b/sum(a)

# chi-matrix
cc   = (x - e)/sqrt(e)

# singular value decomposition
sv   = svd(cc)
g    = sv$u
l    = sv$d
d    = sv$v

# eigenvalues
ll   = l * l

# cumulated percentage of the variance
aux  = cumsum(ll)/sum(ll)
perc = cbind(ll, aux)

r1   = matrix(l, nrow = nrow(g), ncol = ncol(g), byrow = T) * g
r    = (r1/matrix(sqrt(a), nrow = nrow(g), ncol = ncol(g), byrow = F)) * (-1)

s1   = matrix(l, nrow = nrow(d), ncol = ncol(d), byrow = T) * d
s    = (s1/matrix(sqrt(b), nrow = nrow(d), ncol = ncol(d), byrow = F)) * (-1)

car  = matrix(matrix(a), nrow = nrow(r), ncol = ncol(r), byrow = F) * r^2/matrix(l^2, 
    nrow = nrow(r), ncol = ncol(r), byrow = T)           # contribution in r

cas  = matrix(matrix(b), nrow = nrow(s), ncol = ncol(s), byrow = F) * s^2/matrix(l^2, 
    nrow = nrow(s), ncol = ncol(s), byrow = T)           # contribution in s

rr   = r[, 1:2]
ss   = s[, 1:2]

if (wcors == 0) {
    # labels for modalities
    types   = c("A", "B", "C", "D", "E", "F", "G", "H")
    
    # labels for regions
    regions = c("ildf", "cham", "pica", "hnor", "cent", "bnor", "bour", "nopc", 
        "lorr", "alsa", "frac", "payl", "bret", "pcha", "aqui", "midi", "limo", "rhoa", 
        "auve", "laro", "prov")
    
    # plot 1
    plot(rr, type = "n", xlim = c(-0.25, 0.15), ylim = c(-0.15, 0.15), xlab = "r_1,s_1", 
        ylab = "r_2,s_2", main = "Baccalaureat Data", cex.axis = 1.2, cex.lab = 1.2, 
        cex.main = 1.6)
    points(ss, type = "n")
    text(rr, regions, col = "blue")
    text(ss, types, cex = 1.5, col = "red")
    abline(h = 0, v = 0, lwd = 2)
} else {
    # labels for modalities
    types   = c("A", "B", "C", "D", "E", "F", "G", "H")
    
    # labels for regions
    regions = c("ildf", "cham", "pica", "hnor", "cent", "bnor", "bour", "nopc", 
        "lorr", "alsa", "frac", "payl", "bret", "pcha", "aqui", "midi", "limo", "rhoa", 
        "auve", "laro", "prov", "cors")
    
    # plot 2
    plot(rr, type = "n", xlim = c(-0.2, 0.25), ylim = c(-0.5, 0.15), xlab = "r_1,s_1", 
        ylab = "r_2,s_2", main = "Baccalaureat Data", cex.axis = 1.2, cex.lab = 1.2, 
        cex.main = 1.6)
    points(ss, type = "n")
    text(rr, regions, col = "blue")
    text(ss, types, cex = 1.5, col = "red")
    abline(h = 0, v = 0, lwd = 2)
}

```

### SAS Code:
```sas

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
  
  
  

```
