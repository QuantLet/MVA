%% clear all variables and console and close windows
clear
clc
close all

x = [[3 2 1 10]; [2 7 3 4]];

%% plot
xlim([0 12])
ylim([0 8])
text(x(1, 1), x(2, 1), 'Mercedes')
text(x(1, 2), x(2, 2), 'Jaguar')
text(x(1, 3), x(2, 3), 'Ferrari')
text(x(1, 4), x(2, 4), 'VW')
title('Initial Configuration')
box on
