% Clear workspace
clear all
close all
clc

% Add path where your files are located
% addpath C:\Users\
% addpath /Users/

% Load data set
load carc.txt;
cardata = carc;
% ----------------------------------------------------------------------
% Define variables

mileage = cardata(:,2);
weight = cardata(:,8);
displacement = cardata(:,11);
origin = cardata(:,13);
price = cardata(:,1);

% ----------------------------------------------------------------------
% Descriptive plots I

figure(1)
s1 = subplot(2, 2, 1)
scatter(log(weight), log(mileage), 'k')
box on
xlabel('log(Weight)')
ylabel('log(Mileage)')

s2 = subplot(2, 2, 2)
scatter(log(displacement), log(mileage), 'k')
box on
xlabel('log(Displacement)')
ylabel('log(Mileage)')

s3 = subplot(2, 2, 3)
boxplot(log(mileage), origin, 'labels', {'US';'Japan';'Europe'})
box on
xlabel('Origin')
ylabel('log(Mileage)')

s4 = subplot(2, 2, 4)
scatter(log(weight), log(displacement), 'k')
box on
xlabel('log(Weight)')
ylabel('log(Displacement)')


% print -painters -dpdf -r600 SMSlinregcar01.pdf
% print -painters -dpng -r600 SMSlinregcar01.png
% ----------------------------------------------------------------------
% Plot of regression lines with group-specific means

[h, a, c, s] = aoctool(log(weight), log(mileage), origin, 0.05, '', '', '', 'off', 'parallel lines')
slope = cell2mat(c(6, 2));



figure(2)
plot(log(weight(find(origin==1))),log(mileage(find(origin==1))),'sr')
hold on
plot(log(weight(find(origin==2))),log(mileage(find(origin==2))),'^g')
plot(log(weight(find(origin==3))),log(mileage(find(origin==3))),'ob')
box on
us_line = refline(slope, s.intercepts(1));
ja_line = refline(slope, s.intercepts(2));
eu_line = refline(slope, s.intercepts(3));

set(us_line,'LineStyle','-', 'Color','r')
set(ja_line,'LineStyle','--','Color','g')
set(eu_line,'LineStyle',':','Color','b')
legend('US','Japan','Europe')
xlabel('log(Weight)','FontSize',16,'FontWeight','Bold')
ylabel('log(Mileage)','FontSize',16,'FontWeight','Bold')
set(gca,'LineWidth',1.6,'FontSize',16,'FontWeight','Bold')
xlim([7.4 8.6])
hold off
% print -painters -dpdf -r600 SMSlinregcar02.pdf
% print -painters -dpng -r600 SMSlinregcar02.png
