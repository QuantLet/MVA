% ---------------------------------------------------------------------
% Book:         MVA
% ---------------------------------------------------------------------
% Quantlet:     MVAMDScity1
% ---------------------------------------------------------------------
% Description:  MVAMDScity1 computes the map of the cities by application 
%               of multidimensional scaling. 
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

%aa,bb,hh,ii are matrices
aa=(dist.^2).*(-0.5);

ii=eye(6,6);
u=ones(1,6);

hh=ii-(1/6*(u'*u));

bb=hh*aa*hh; %Determine the inner product matrix

[v e]=eigs(bb);

x=v*(e.^0.5); %Determine the coordinate matrix

hold on
scatter(x(:,1),x(:,2),'k')
title('Initial Configuration')
xlabel('NORTH - SOUTH - DIRECTION in km')
ylabel('EAST - WEST - DIRECTION in km')
xlim([-500 700])
ylim([-500 300])
set(gca,'box','on')

text(x(1,1)+20,x(1,2),'Berlin','Color','b')
text(x(2,1)+20,x(2,2),'Dresden','Color','b')
text(x(3,1)+20,x(3,2),'Hamburg','Color','b')
text(x(4,1)+20,x(4,2),'Koblenz','Color','b')
text(x(5,1)+20,x(5,2),'Muenchen','Color','b')
text(x(6,1)+20,x(6,2),'Rostock','Color','b')

hold off
