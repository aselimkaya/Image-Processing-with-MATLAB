imRGB = imread('logo.jpg');
imBIG = rgb2gray(imRGB); %RGB resmi gray scale'a �evirdik.
im = imresize(imBIG, [100 100]); % 100x100'e scale ettik.

intensityArr = reshape(im, [10000,1]); %matrisi tek boyutlu bir diziye �evirip 
                                       %s�ralama i�lemine haz�r hale
                                       %getirdik

sortedArr = sort(intensityArr, 'descend'); % azalan s�ra ile s�raland�

disp(sortedArr);

histogramArr = zeros([20 1]);

for k = 1:10000
    val = sortedArr(k);
    val2 = double(val)/(12.75); % 255 rengi 20 gruba b�l�nce gruplar 12.75'er aral�kl� oldu
    val3 = fix(val2); %ka��nc� grupta oldu�unu buluyoruz
    histogramArr(val3) = histogramArr(val3) + 1; %o grubun count'unu 1 art�r�yoruz
end

bar(histogramArr);