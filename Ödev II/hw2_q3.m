im = imread('grayscale.jpg');

gaussMask = fspecial('gaussian',11,3);

figure
IGauss = imfilter(im,gaussMask,'conv');
imshow(IGauss);

figure
IBox = imboxfilt(im,11);
imshow(IBox);