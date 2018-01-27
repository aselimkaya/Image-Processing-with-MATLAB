imRGB = imread('logo.jpg');
imBIG = rgb2gray(imRGB);
im = imresize(imBIG, [100 100]);

[x, y] = size(im);

out = zeros(x/2, y/2, 'uint8'); %�eyre�i b�y�kl�kte olacaksa yar�s� boyutlu olmal�

for R = x/2:x
    for C = 1:y/2
        out(R - x/2 + 1, C) = im(R, C); %sol alt k�sm�n� bulduk
    end
end

imshow(out);