%% The function rot2d
function [rotZ] = rot2d(ang)
% This is a 2-dimensional rotation matrix, along the z-Axis in the
% Cartesian coordinate system, in the positive direction i.e. anti-clock
% wise.
% 
% Author: M.H. Jaafar
% 
% Input: ang => angle in radian, measured from x-axis in the Quadrant I of
% the coordinate system.
% Output: rotZ => The rotation matrix of size 2x2.
% 
% Example: Angle 45� or pi/4 :
% >> Rz = rot2d(pi/4)
% 
% Rz =
% 
%     0.5253   -0.8509
%     0.8509    0.5253
    
rotZ(1,1) = cos(ang);
rotZ(1,2) = -sin(ang);
rotZ(2,1) = sin(ang);
rotZ(2,2) = cos(ang);