imRGB = imread('logo.jpg');
imBIG = rgb2gray(imRGB);
im = imresize(imBIG, [100 100]);

valueArr = reshape(im, [10000,1]); %matrisi diziye çevirdik

avg = mean(valueArr); %ortalama deðeri bulduk

[x, y] = size(im);

for R = 1:x
    for C = 1:y
        im(R, C) = im(R, C) - avg; %bütün deðerlerden ortalama deðeri çýkardýk
    end
end

imshow(im);