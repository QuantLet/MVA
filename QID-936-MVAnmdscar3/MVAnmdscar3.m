%% clear all variables and console and close windows
clear
clc
close all

x = [3    2
    2    7
    1    3
    0.37 4.36
    10   4];

x = x';

%% plot
hold on
title('First Iteration for Ferrari')
xlim([0 12])
ylim([0 8])
labels = {'Mercedes    ', 'Jaguar      ', 'Ferrari Init',...
          'Ferrari New ', 'VW          '}
scatter(x(1, :), x(2, :), 90, 'r', 'fill')
text(x(1, :) + 0.2, x(2, :), labels)
line([x(1, 3) x(1, 4)], [x(2, 3) x(2, 4)], 'Color', 'r', 'LineWidth', 2)
box on
hold off
