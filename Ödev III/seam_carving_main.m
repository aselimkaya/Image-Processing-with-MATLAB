im = imread('human_head.jpg');
im = rgb2gray(im);

imOut = yukseklikArtir(im,20,1);

imshow(imOut);