%% clear all variables and console and close windows
clear
clc
close all

%% load data  
x              = load('bank2.dat');
[n,p]          = size(x);
x(:,[1,2,3,6]) = x(:,[1,2,3,6])/10;

groups = vertcat(ones(100,1),zeros(100,1)); % Creates a vector with ones in the first 100 entries and zeros in the rest
                                            % This vector enables us to use the 'gscatter'command to plot the data in groups.

adjust = (n-1)*cov(x)/n;
[v,e]  = eigs(adjust,p,'la'); % Calculates eigenvalues and eigenvectors and sorts them by size
e1     = diag(e);             % Creates column vector of eigenvalues

% change the signs of some eigenvector. This is done only to make easier
% the comparison with R results.
v(:,[1,3,5,6]) = -v(:,[1,3,5,6]);

x = x*v;

%% plots
nr = 1:6;

%% plot of Eigenvalues
subplot(2,2,4,'FontSize',20)
scatter(nr,e1,25,'k')
xlabel('Index')
ylabel('Lambda')
title('Eigenvalues of S')
xlim([0.5 6.5])
ylim([-0.2 2.5])

%% plot of the first vs. second PC
subplot(2,2,1,'FontSize',20)
gscatter(x(:,1),x(:,2),groups,'br','+o',5,'off')
xlabel('PC1 ')
ylabel('PC2 ')
title('First vs. Second PC')

%% plot of the second vs. third PC
subplot(2,2,2,'FontSize',20)
gscatter(x(:,2),x(:,3),groups,'br','+o',5,'off')
xlabel('PC2 ')
ylabel('PC3 ')
title('Second vs. Third PC')

%% plot of the first vs. third PC
subplot(2,2,3,'FontSize',20)
gscatter(x(:,1),x(:,3),groups,'br','+o',5,'off')
xlabel('PC1 ')
ylabel('PC3 ')
title('First vs. Third PC')
