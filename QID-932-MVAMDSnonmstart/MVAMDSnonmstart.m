% -------------------------------------------------------------------------
% Book:         MVA
% -------------------------------------------------------------------------
% Quantlet:     MVAMDSnonmstart
% -------------------------------------------------------------------------
% Description:  MVAMDSnonmstart computes the monotonic regression and shows
%               the rank order of dissimilarities for the pool-adjacent 
%               violators (PAV) algorithm.
% -------------------------------------------------------------------------
% Usage:        -
% -------------------------------------------------------------------------
% Inputs:       None
% -------------------------------------------------------------------------
% Output:       Plot of the monotonic regression and rank order of
%               dissimilarities.
% -------------------------------------------------------------------------
% Example:      -
% -------------------------------------------------------------------------
% Author:       Wolfgang Haerdle, Vladimir Georgescu, Jorge Patron, Song 
%               Song
% -------------------------------------------------------------------------

close all
clear
clc

ber=[0  2  4  12 11 3 ];
dre=[2  0  6  10 7  5 ];
ham=[4  6  0  8  15 1 ];
kob=[12 10 8  0  9  13];
mue=[11 7  15 9  0  14];
ros=[3  5  1  13 14 0 ];

dist=[ber', dre', ham', kob', mue', ros'];

%aa,bb,hh,ii are matrices

aa=(dist.^2).*(-0.5);

ii=eye(6,6);
u=ones(1,6);

hh=ii-(1/6*(u'*u));

bb=hh*aa*hh; %Determine the inner product matrix

[v e]=eigs(bb);

g1(:,1)=v(:,1);
g1(:,2)=v(:,2);

g2(1,1)=e(1,1);
g2(2,2)=e(2,2);
g2(1,2)=0;
g2(2,1)=0;

x=g1*(g2.^0.5); %Determine the coordinate matrix

%Determine the dissimilarities
d12=((x(1,1)-x(2,1))^2+(x(1,2)-x(2,2))^2)^0.5;
d13=((x(1,1)-x(3,1))^2+(x(1,2)-x(3,2))^2)^0.5;
d14=((x(1,1)-x(4,1))^2+(x(1,2)-x(4,2))^2)^0.5;
d15=((x(1,1)-x(5,1))^2+(x(1,2)-x(5,2))^2)^0.5;
d16=((x(1,1)-x(6,1))^2+(x(1,2)-x(6,2))^2)^0.5;

d23=((x(2,1)-x(3,1))^2+(x(2,2)-x(3,2))^2)^0.5;
d24=((x(2,1)-x(4,1))^2+(x(2,2)-x(4,2))^2)^0.5;
d25=((x(2,1)-x(5,1))^2+(x(2,2)-x(5,2))^2)^0.5;
d26=((x(2,1)-x(6,1))^2+(x(2,2)-x(6,2))^2)^0.5;

d34=((x(3,1)-x(4,1))^2+(x(3,2)-x(4,2))^2)^0.5;
d35=((x(3,1)-x(5,1))^2+(x(3,2)-x(5,2))^2)^0.5;
d36=((x(3,1)-x(6,1))^2+(x(3,2)-x(6,2))^2)^0.5;

d45=((x(4,1)-x(5,1))^2+(x(4,2)-x(5,2))^2)^0.5;
d46=((x(4,1)-x(6,1))^2+(x(4,2)-x(6,2))^2)^0.5;

d56=((x(5,1)-x(6,1))^2+(x(5,2)-x(6,2))^2)^0.5;


dd=[[0 d12 d13 d14 d15 d16];[d12 0 d23 d24 d25 d26];[d13 d23 0 d34 d35 d36];[d14 d24 d34 0 d45 d46];[d15 d25 d35 d45 0 d56];[d16 d26 d36 d46 d56 0]];

ff=[[1:15]',[d12;d13;d14;d15;d16;d23;d24;d25;d26;d34;d35;d36;d45;d46;d56]]; %Determine the rank order to dissimilarities

ll=[[15;1],[14.4;3.17]];

scatter(ff(:,1),ff(:,2),'k')
title('Monotonic Regression')
xlabel('Rank')
ylabel('Distance')
xlim([0 16])
set(gca,'box','on')

for i=1:14
    line([ff(i,1) ff(i+1,1)],[ff(i,2) ff(i+1,2)],'Color','b','LineWidth',1.5,'LineStyle','--')
end

line([ll(1,1) ll(2,1)],[ll(1,2) ll(2,2)],'Color','b','LineWidth',2)
