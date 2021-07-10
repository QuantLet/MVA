%% clear all variables and console and close windows
clear
clc
close all

%% data
x1 = [2 3 4 2.8 3];         %Define group 1
x2 = [1.5 2 1.5 2 2.2];     %Define group 2

%% plot
plot(x1,'r','LineWidth',2)
title('Population Profiles')
xlabel('Treatment')
ylabel('Mean')
hold on 
plot(x2,'b','LineWidth',2,'Linestyle','--')
legend('Group 1','Group 2')
axis([1 5 0 5])
hold off
