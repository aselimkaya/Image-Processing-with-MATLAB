imRGB = imread('logo.jpg');
imBIG = rgb2gray(imRGB); %RGB resmi gray scale'a çevirdik.
im = imresize(imBIG, [100 100]); % 100x100'e scale ettik.

intensityArr = reshape(im, [10000,1]); %matrisi tek boyutlu bir diziye çevirip 
                                       %sýralama iþlemine hazýr hale
                                       %getirdik

sortedArr = sort(intensityArr, 'descend'); % azalan sýra ile sýralandý

disp(sortedArr);

histogramArr = zeros([20 1]);

for k = 1:10000
    val = sortedArr(k);
    val2 = double(val)/(12.75); % 255 rengi 20 gruba bölünce gruplar 12.75'er aralýklý oldu
    val3 = fix(val2); %kaçýncý grupta olduðunu buluyoruz
    histogramArr(val3) = histogramArr(val3) + 1; %o grubun count'unu 1 artýrýyoruz
end

bar(histogramArr);