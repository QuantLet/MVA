%% clear all variables and console and close windows
clear
clc
close all

%% data
ber = [0  2  4  12 11 3 ];
dre = [2  0  6  10 7  5 ];
ham = [4  6  0  8  15 1 ];
kob = [12 10 8  0  9  13];
mue = [11 7  15 9  0  14];
ros = [3  5  1  13 14 0 ];
dist=[ber', dre', ham', kob', mue', ros'];

%% matrices aa, bb, hh, ii
aa = (dist .^ 2) .* (-0.5);
ii = eye(6, 6);
u  = ones(1, 6);
hh = ii - (1/6 * (u' * u));
bb = hh * aa * hh; % Determine the inner product matrix

[g1, g2] = eigs(bb, 2);

x = g1 * (g2 .^ 0.5); % Determine the coordinate matrix

%% Determine the dissimilarities
d12 = ((x(1, 1) - x(2, 1))^2 + (x(1, 2) - x(2, 2))^2)^0.5;
d13 = ((x(1, 1) - x(3, 1))^2 + (x(1, 2) - x(3, 2))^2)^0.5;
d14 = ((x(1, 1) - x(4, 1))^2 + (x(1, 2) - x(4, 2))^2)^0.5;
d15 = ((x(1, 1) - x(5, 1))^2 + (x(1, 2) - x(5, 2))^2)^0.5;
d16 = ((x(1, 1) - x(6, 1))^2 + (x(1, 2) - x(6, 2))^2)^0.5;

d23 = ((x(2, 1) - x(3, 1))^2 + (x(2, 2) - x(3, 2))^2)^0.5;
d24 = ((x(2, 1) - x(4, 1))^2 + (x(2, 2) - x(4, 2))^2)^0.5;
d25 = ((x(2, 1) - x(5, 1))^2 + (x(2, 2) - x(5, 2))^2)^0.5;
d26 = ((x(2, 1) - x(6, 1))^2 + (x(2, 2) - x(6, 2))^2)^0.5;

d34 = ((x(3, 1) - x(4, 1))^2 + (x(3, 2) - x(4, 2))^2)^0.5;
d35 = ((x(3, 1) - x(5, 1))^2 + (x(3, 2) - x(5, 2))^2)^0.5;
d36 = ((x(3, 1) - x(6, 1))^2 + (x(3, 2) - x(6, 2))^2)^0.5;

d45 = ((x(4, 1) - x(5, 1))^2 + (x(4, 2) - x(5, 2))^2)^0.5;
d46 = ((x(4, 1) - x(6, 1))^2 + (x(4, 2) - x(6, 2))^2)^0.5;

d56 = ((x(5, 1) - x(6, 1))^2 + (x(5, 2) - x(6, 2))^2)^0.5;

d14 = (d14 + d15)/2;
d15 = d14;
d16 = (d14 + d15 + d16 + d23 + d24 + d25 + d26)/7;
d14 = d16;
d15 = d16;
d23 = d16;
d24 = d16;
d25 = d16;
d26 = d16;
d35 = (d35 + d36)/2;
d36 = d35;

dd = [[0 d12 d13 d14 d15 d16];
      [d12 0 d23 d24 d25 d26];
      [d13 d23 0 d34 d35 d36];
      [d14 d24 d34 0 d45 d46];
      [d15 d25 d35 d45 0 d56];
      [d16 d26 d36 d46 d56 0]];

ff = [[1:15]',...
      [d12;d13;d14;d15;d16;d23;d24;d25;d26;d34;d35;d36;d45;d46;d56]];

ll = [[15;1],[14.4;3.17]];

%% plot
scatter(ff(:, 1), ff(:, 2), 'k')
title('Pool-Adjacent-Violator-Algorithm')
xlabel('Rank')
ylabel('Distance')
xlim([0 16])
set(gca, 'box', 'on')

for i=1:14
    line([ff(i, 1) ff(i + 1, 1)], [ff(i, 2) ff(i + 1, 2)],...
         'Color', 'b', 'LineWidth', 1.5, 'LineStyle', '--')
end

line([ll(1,1) ll(2,1)],[ll(1,2) ll(2,2)],'Color','b','LineWidth',2)
