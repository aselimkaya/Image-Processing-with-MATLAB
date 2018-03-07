im = imread('Istanbul.jpg');
im = rgb2gray(im);

out = ApplySobelFilter(double(im));

imshow(mat2gray(out));