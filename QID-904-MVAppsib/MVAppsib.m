% ------------------------------------------------------------------------------
% Book:         MVA
% ------------------------------------------------------------------------------
% Quantlet:     MVAppsib
% ------------------------------------------------------------------------------
% Description:  MVAppsib reads the Boston housing data (bostonh.dat) and spheres them to run 
%               Exploratory Projection Pursuit (EPP) on them.
%               We select n (=50) randomly chosen one dimensional projections in 
%               the space of the data. For each set of projected
%               data the Sibson Jones index is applied, which considers the 
%               deviations from the normal density for univariate data, to judge the 
%               "interestingness" of the projection.
% ------------------------------------------------------------------------------
% Usage:        ppsib.m, ppsibexample.m, sphere.m
% ------------------------------------------------------------------------------
% Inputs:       None      
% ------------------------------------------------------------------------------
% Output:       In the graphics we see the density for the standard normal
%               distributed data (green) and the estimated densities for the
%               best (red) and the worst (blue) projections found. Additionally
%               we see a dotplot of the projections. In the lower part, we see 
%               the values of the Sibson Jones index.
% ------------------------------------------------------------------------------
% Example:      -
% ------------------------------------------------------------------------------
% Author:       Anastasiadou, Zografia
%               Awdesch Melzer 20130924
% ------------------------------------------------------------------------------

% clear variables and close windows
clear all;
close all;
clc;

RandStream.setGlobalStream(RandStream('mt19937ar','seed',100));

% load data
x = load('bostonh.dat');


% uncomment the next lines for transformed data
% xt       = x;
% xt(:,1)  = log(x(:,1));
% xt(:,2)  = x(:,2)./10;
% xt(:,3)  = log(x(:,3));
% xt(:,5)  = log(x(:,5));
% xt(:,6)  = log(x(:,6));
% xt(:,7)  = (x(:,7).^(2.5))./10000;
% xt(:,8)  = log(x(:,8));
% xt(:,9)  = log(x(:,9));
% xt(:,10) = log(x(:,10));
% xt(:,11) = exp(0.4*x(:,11))./1000;
% xt(:,12) = x(:,12)./100;
% xt(:,13) = sqrt(x(:,13));
% xt(:,14) = log(x(:,14));
% x = xt;

x(:,4) = [];

%

% sphere the data
x = sphere(x);

% choose bandwidth
h = 1.06*length(x)^(-1/5).*max(std(x));

% choose number of projections
n = 50;

[xa xi fa fi tit pind cind] = ppsibexample(x, h, n);

 
subplot(5,1,1:4);
    plot(fi(:,1),fi(:,2),'b-','LineWidth',2)
    hold on;
    plot(xa(1:100,1),xa(1:100,2),'ro')
    plot([-4:0.01:4]',normpdf([-4:0.01:4]',0,1),'g-','LineWidth',2)
    ylim([-0.2,0.5]);
    xlim([-4,4]);
    plot(xa(101:200,1),xa(101:200,2),'r^')
    plot(xi(1:100,1),xi(1:100,2),'bo')
    plot(xi(101:200,1),xi(101:200,2),'b^')
    ylabel('Y','FontWeight','bold','FontSize',16);
    xlabel('X','FontWeight','bold','FontSize',16);
    line(fa(:,1),fa(:,2),'color','r','LineWidth',2)
    box on
    set(gca,'FontSize',16,'LineWidth',2,'FontWeight','bold');
    hold off;
    title(tit,'FontWeight','bold','FontSize',16);
subplot(5,1,5);
    plot(pind(:,1),pind(:,2),'ko')
    hold on
    plot(pind(find(cind==1),1),pind(find(cind==1),2),'bo')
    plot(pind(find(cind==2),1),pind(find(cind==2),2),'go')
    plot(pind(find(cind==4),1),pind(find(cind==4),2),'ro')
    box on;
    set(gca,'FontSize',16,'LineWidth',2,'FontWeight','bold');
    hold off
    
  %   print -painters -dpdf -r600 MVAppsib_orig.pdf
  %   print -painters -dpng -r600 MVAppsib_orig.png
