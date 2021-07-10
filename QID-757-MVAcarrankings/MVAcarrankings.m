%% clear all variables and console and close windows
clear
clc
close all

%% the reported preference orderings
x = (1:6)';

% the estimated preference orderings according to the additive model (16.1) 
% and the metric solution (Table 16.6) in book
y = [0.84, 2.84, 3.16, 3.34, 5.66, 5.16]';
z = [x, y];

%% use PAV algorithm
gp = pava(y);

%% the reported preference orderings
gp = [x, gp];

%% plot
figure(1)
hold on
plot(gp, z, 'w')
xlabel('Revealed rankings', 'FontSize', 12)
ylabel('Estimated rankings', 'FontSize', 12)
title('Car rankings', 'FontSize', 14)
box on
line(gp(:, 1), gp(:, 2), 'LineWidth', 2)
scatter(x, y, 'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red')%'filled', true)
xlim([0.5, 6.5])
labels = {'car1', 'car2', 'car3', 'car4', 'car5', 'car6'};
text(x, y - 0.1, labels, 'FontSize',12)
hold off
