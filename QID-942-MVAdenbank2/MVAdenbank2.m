%% clear loaded variables and close windows
clear all
close all
clc

%% load data
x  = load('bank2.dat')
x4 = x(1:100,4);
x5 = x(1:100,5);

[f1,xi1] = ksdensity(x4);
[f2,xi2] = ksdensity(x5);

%% plot
hold on
subplot(1,2,1)
plot(xi1,f1,'k','linewidth',2)
title('Swiss Bank Notes')
xlabel('Lower Inner frame (x4)')
ylabel('Density')
subplot(1,2,2)

plot(xi2,f2,'k','linewidth',2)
title('Swiss Bank Notes')
xlabel('Upper Inner Frame (X5)')
ylabel('Density')
hold off
