function [ u, v ] = world2Cam2D( M, x, y )
%UNT�TLED3 Summary of this function goes here
%   Detailed explanation goes here

wCoord = [x;y;1];
cameraCoord = M*wCoord;

u = cameraCoord(1);
v = cameraCoord(2);

end

