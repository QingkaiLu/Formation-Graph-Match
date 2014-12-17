function [pgmPnts] = Pentagram(r, h, k, noSides)
%% Pentagram
%  Author: M.H. Jaafar, Uni. of Applied Sciences of Darmstadt (Germany),
%  Faculty of Mathematics and Natural Sciences, Dept. of Computer Vision
%  and Photonics, Dec. 2012. Twitter: @HafizVonPJ. Blog:
%  mhafizjaafar.blogspot.com .
% 
% This is a MATLAB code to plot the symbol of pentagram on a Cartesian
% coordinate system. The symbol consists of 1 circle and 1 pentagram - a
% 5-pointed star drawn with 5 straight strokes.
% 
% Basically this algorithm focuses on the getting the coordinates to draw:
% (1) the circle and (2) the horizontal line. Later the horizonzal line is
% manipulated to generate the other 4 lines to form the pentagram.

%% The variables

n = 2^8; % Number of sampling points
t = linspace(0,2*pi,n); % Interval
% noSides = 5; % Number of sides of the polygonuntitled.jpg
innerAngle = 2*pi/noSides; % Interior angle of a pentagon.

% Variables for the cirle
% r = 2; % Radius
% h = 0; % Transition distance
% k = 0; % Transition distance

xsfact = 1.3; % Factor to extend the display range of the xy-axes.

%% Equations for the circle

x = r*cos(t)+h;
y = r*sin(t)+k;

%% Equation(s) for the horizontal line

% The length of the horizontal line
lH = r*sin(innerAngle)*2;
% Distance to the horizontal line from the center 
dist_lH = r*cos(innerAngle);
% The definition interval of the horizontal line
xH = linspace(-lH/2, lH/2, n);

%% Rotation
% Here the horizontal line from the previous will be simply duplicated for
% 4 times. Every point (x,y) will be multiplied with a 2D-rotation matrix.

side = zeros(2,n);
side(1,:) = xH;
side(2,:) = -dist_lH;

side1rot = rot2d(innerAngle)*side;
side2rot = rot2d(innerAngle*2)*side;
side3rot = rot2d(innerAngle*3)*side;
side4rot = rot2d(innerAngle*4)*side;

xH = xH + h;
dist_lH = dist_lH - k;
side1rot(1, :) = side1rot(1, :) + h;
side1rot(2, :) = side1rot(2, :) + k;
side2rot(1, :) = side2rot(1, :) + h;
side2rot(2, :) = side2rot(2, :) + k;
side3rot(1, :) = side3rot(1, :) + h;
side3rot(2, :) = side3rot(2, :) + k;
side4rot(1, :) = side4rot(1, :) + h;
side4rot(2, :) = side4rot(2, :) + k;


% stPnt = [10 0];
% x = x + stPnt(1);
% y = y + stPnt(2);
% xH = xH + stPnt(1);
% dist_lH = dist_lH - stPnt(2);
% side1rot(1, :) = side1rot(1, :) + stPnt(1);
% side1rot(2, :) = side1rot(2, :) + stPnt(2);
% side2rot(1, :) = side2rot(1, :) + stPnt(1);
% side2rot(2, :) = side2rot(2, :) + stPnt(2);
% side3rot(1, :) = side3rot(1, :) + stPnt(1);
% side3rot(2, :) = side3rot(2, :) + stPnt(2);
% side4rot(1, :) = side4rot(1, :) + stPnt(1);
% side4rot(2, :) = side4rot(2, :) + stPnt(2);

%% Plotting

% figure,
hold on
plot(x,y, 'r')
plot(xH, -dist_lH, 'r')
plot(side1rot(1,:), side1rot(2,:), 'r')
plot(side2rot(1,:), side2rot(2,:), 'r')
plot(side3rot(1,:), side3rot(2,:), 'r')
plot(side4rot(1,:), side4rot(2,:), 'r')
% hold off
% axis(xsfact.*[min(x) max(x) min(y) max(y)])
% title('Das Pentagramm')

% size(dist_lH)
% dist_1H * ones(1, size(xH, 2))
pgmPnts = [xH; -dist_lH * ones(1, size(xH, 2))];
pgmPnts = [pgmPnts side1rot side2rot side3rot side4rot];
% pgmPnts = [pgmPnts(:, 1) side1rot(:, 1) side2rot(:, 1) side3rot(:, 1) side4rot(:, 1)];
%plot(pgmPnts(1,:), pgmPnts(2,:), 'r')
% plot([-1 0 1], [0 0 1])
% plot([1 2 3 4 5 6 ], [1 2 3 4 5 6])
%plot([-1 0 1 1 2 3 4 5 6 ], [0 0 1 1 2 3 4 5 6])

