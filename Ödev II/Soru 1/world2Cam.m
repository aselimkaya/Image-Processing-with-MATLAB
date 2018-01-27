function [u,v] = world2Cam(M,x,y,z)
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here
wCoord = [x;y;z;1];
cameraCoord = M*wCoord;

u = cameraCoord(1)/cameraCoord(3);
v = cameraCoord(2)/cameraCoord(3);


end

