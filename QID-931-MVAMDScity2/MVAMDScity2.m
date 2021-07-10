% ---------------------------------------------------------------------
% Book:         MVA
% ---------------------------------------------------------------------
% Quantlet:     MVAMDScity2
% ---------------------------------------------------------------------
% Description:  MVAMDScity2 computes the map of the cities by application 
%               of multidimensional scaling. Reflects and rotates the 
%               figure by 90
%               Corresponds to example 16.1 in MVA. 
% ---------------------------------------------------------------------
% Usage:        -
% ---------------------------------------------------------------------
% Inputs:       None
% ---------------------------------------------------------------------
% Output:       Map of the cities as a metric MDS solution for the
%               inter-city road distances.
% ---------------------------------------------------------------------
% Example:      -
% ---------------------------------------------------------------------
% Author:       Wolfgang Haerdle, Vladimir Georgescu, Jorge Patron,
%               Song Song
% ---------------------------------------------------------------------

close all
clear
clc

%Intercity road distances
ber=[0 214 279 610 596 237];
dre=[214 0 492 533 496 444];
ham=[279 492 0 520 772 140];
kob=[610 533 520 0 521 687];
mue=[596 496 772 521 0 771];
ros=[237 444 140 687 771 0];

dist=[ber', dre', ham', kob', mue', ros'];

% aa, bb, hh, ii, rr, xx, xx1, xx2 are matrices
%aa,bb,hh,ii are matrices
aa=(dist.^2).*(-0.5);

ii=eye(6,6);
u=ones(1,6);

hh=ii-(1/6*(u'*u));

bb=hh*aa*hh; %Determine the inner product matrix

[v e]=eigs(bb);

g1(:,1)=v(:,1);
g1(:,2)=-v(:,2);

g2(1,1)=e(1,1);
g2(2,2)=e(2,2);
g2(1,2)=0;
g2(2,1)=0;

xx1=g1*(g2.^0.5); %Determine the coordinate matrix

x=cos(pi/2);
y=sin(pi/2);
z=-sin(pi/2);

rr(1,1)=x;
rr(1,2)=z;
rr(2,1)=y;
rr(2,2)=x;

xx2=xx1*rr;
xx=[(xx2(:,1)*(-1))+500 (xx2(:,2))+500];

hold on
scatter(xx(:,1),xx(:,2),'k')
title('Map of German Cities')
xlabel('EAST - WEST - DIRECTION in km')
ylabel('NORTH - SOUTH - DIRECTION in km')
xlim([0 900])
ylim([0 900])
set(gca,'box','on')

text(xx(1,1)+20,xx(1,2),'Berlin','Color','b')
text(xx(2,1)+20,xx(2,2),'Dresden','Color','b')
text(xx(3,1)+20,xx(3,2),'Hamburg','Color','b')
text(xx(4,1)+20,xx(4,2),'Koblenz','Color','b')
text(xx(5,1)+20,xx(5,2),'Muenchen','Color','b')
text(xx(6,1)+20,xx(6,2),'Rostock','Color','b')


