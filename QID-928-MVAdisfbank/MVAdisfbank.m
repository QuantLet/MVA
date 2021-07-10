% ---------------------------------------------------------------------
% Book:         MVA
% ---------------------------------------------------------------------
% Quantlet:     MVAdisfbank
% ---------------------------------------------------------------------
% Description:  MVAdisfbank performs a Fisher discrimination analysis
%               of the Swiss bank notes (bank2.dat), computes the
%               miss-classification rates for the whole dataset and
%               displays nonparametric density estimates of the
%               projected data.
%               Corresponds to example 13.6 in MVA.
% ---------------------------------------------------------------------
% Usage:        -
% ---------------------------------------------------------------------
% Inputs:       None
% ---------------------------------------------------------------------
% Output:       Fisher discrimination analysis of the Swiss bank notes
%               (bank2.dat), miss-classification rates for the whole
%               dataset and plot of the nonparametric density
%               estimates of the projected data.
% ---------------------------------------------------------------------
% Example:      -
% ---------------------------------------------------------------------
% Author:       Wolfgang Haerdle, Vladimir Georgescu, Jorge Patron,
%               Song Song
% ---------------------------------------------------------------------
%% clear all variables and console and close windows
clear
clc
close all

%% load data
x = load('bank2.dat'); 

xg = x(1:100,:);       % Group first 100 observations
xf = x(101:200,:);     % Group second 100 observations

% Determine the mean for the seperate groups and overall sample
mg = mean(xg);         
mf = mean(xf);
m  = (mf+mg)/2;

w = 100*(cov(xg)+cov(xf));
d = mg-mf;             % Difference in means
a = inv(w)*d';         % Determine the factors for linear combinations

yg = (xg-repmat(m,100,1))*a; %Discriminant rule
yf = (xf-repmat(m,100,1))*a; %Discriminant rule

% Number of misclassified genuine notes
sumg = 0;
for i=1:length(yg)
    if yg(i)<0
        sumg = sumg+1;
    end
end

disp('Number of missclassified genuine notes');
disp(sumg)

% Number of misclassified forged notes
sumf = 0;
for i=1:length(yf)
    if yf(i)>0
        sumf = sumf+1;
    end
end

disp('Number of missclassified forged notes');
disp(sumf)

% Show densities of projections of genuine and counterfeit bank %notes by Fisher’s discrimination rule.

[f1,ygi1] = ksdensity(yg);
[f2,ygi2] = ksdensity(yf);

hold on
title('Swiss Bank Notes');
ylabel('Densities of Projections');
xlim([-0.2 0.2]);
plot(ygi1,f1,'color','b','LineWidth',2,'LineStyle','--');
plot(ygi2,f2,'color','r','LineWidth',2);
text(-0.14,3.5,'Forged','Color','r');
text(0.1,2,'Genuine','Color','b');
box on
hold off
