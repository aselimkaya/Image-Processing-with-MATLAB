im = imread('grayscale.jpg');

gaussMask = fspecial('gaussian',15,4);

figure
imGauss = convolutional_filter(gaussMask, double(im));
imshow(imGauss);

figure
boxFilter = ones(15, 15)*1/255;
imBox = convolutional_filter(boxFilter, double(im));
imshow(imBox);