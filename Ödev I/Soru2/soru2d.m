imRGB = imread('logo.jpg');
imBIG = rgb2gray(imRGB);
im = imresize(imBIG, [100 100]);

[x, y] = size(im);

out = zeros(x/2, y/2, 'uint8'); %çeyreði büyüklükte olacaksa yarýsý boyutlu olmalý

for R = x/2:x
    for C = 1:y/2
        out(R - x/2 + 1, C) = im(R, C); %sol alt kýsmýný bulduk
    end
end

imshow(out);