imRGB = imread('logo.jpg');
imBIG = rgb2gray(imRGB);
im = imresize(imBIG, [100 100]);

valueArr = reshape(im, [10000,1]); %matrisi diziye �evirdik

avg = mean(valueArr); %ortalama de�eri bulduk

[x, y] = size(im);

for R = 1:x
    for C = 1:y
        im(R, C) = im(R, C) - avg; %b�t�n de�erlerden ortalama de�eri ��kard�k
    end
end

imshow(im);