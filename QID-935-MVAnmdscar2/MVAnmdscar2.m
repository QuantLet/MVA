%% clear all variables and console and close windows
clear
clc
close all

x = [[3 2 1 10]; [2 7 3 4]];

d = dist(x);

delta = [1 2 3 d(1,2)
         1 3 2 d(1,3)
         1 4 5 d(1,4)
         2 3 1 d(2,3)
         2 4 4 d(2,4)
         3 4 6 d(3,4)];

fig = [1 d(2,3)   
       2 d(1,3)   
       3 d(1,2)  
       4 d(2,4)   
       5 d(1,4)   
       6 d(3,4)];
  
%% plot
scatter(fig(:, 1), fig(:, 2), 'b', 's', 'fill')
xlim([0 7])
ylim([0 10])
title('Dissimilarities and Distances')
xlabel('Dissimilarity')
ylabel('Distance')
for i=1:5
    line([fig(i, 1) fig(i + 1, 1)], [fig(i, 2) fig(i + 1, 2)],...
         'Color', 'k', 'LineWidth',1.5)
end
labels = {'(2,3)', '(1,3)', '(1,2)', '(2,4)', '(1,4)', '(3,4)'};
text(fig(:, 1) + 0.2, fig(:, 2), labels, 'Color', 'r')
