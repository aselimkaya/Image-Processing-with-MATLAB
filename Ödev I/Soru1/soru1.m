im1 = imread('gray.jpg');
im2 = imread('gerbera.jpg');

[x, y] = size(im1);

% resimler gray scale mi yoksa rgb mi kontrolü
if(size(im1,3)==3)
    yForOut = y/3;
else 
    yForOut = y;
end

alpha = 0.5;
out = zeros(x, yForOut, 3, 'uint8');

for R=1:x
    for C=1:y
        pixel1 = im1(R, C);
        pixel2 = im2(R, C);
        out(R, C) = (1-alpha) * pixel1 + alpha * pixel2;
    end
end

imshow(out);