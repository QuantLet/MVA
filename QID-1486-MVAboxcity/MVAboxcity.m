%% Clear variables and close windows
close all
clear
clc

%% Load data
x  = load('cities.txt');
m1 = mean(x);

%% Plot box plot
hold on
boxplot(x,'Symbol','o','label',{'World Cities'},'widths',0.5)
line([0.75 1.25],[m1 m1],'Color','k','LineStyle',':','LineWidth',1.2)
title('Boxplot')
hold off

%% Five Number Summary%
% Matlab "quantile" function uses a different algorithm to calculate the sample quantiles than in the MVA book%
% Therefore, the values using Matlab could differ from the Book values, but
% the difference is not great, and should not be significant.
% Easiest way to calculate Five Number Summary is
% quantile(population,[.025 .25 .50 .75 .975])
five = quantile(x,[.025 .25 .50 .75 .975]);

%% Display results
disp('Five number summary, in millions')
disp('     0.025     0.25      0.5       0.75     0.975 ')
disp(five/100)