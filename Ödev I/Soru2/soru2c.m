threshold = 180;

im1BIG = imread('earth.jpg');
im1 = imresize(im1BIG, [100 100]);

im2RGB = imread('logo.jpg');
im2BIG = rgb2gray(im2RGB);
im2 = imresize(im2BIG, [100 100]);

[x, y] = size(im2);

for R=1:x
    for C=1:y
        if(im2(R, C) > threshold)
             im1(R, C, :) = [255, 0, 0]; %pixel deðeri thresholddan büyükse kýrmýzýya boyadýk
        end
    end
end

imshow(im1);
