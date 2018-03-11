image = imread('blox.gif');
image = imresize(image,[300 300]);

% outSingle sadece 1 filtreyi uyguladýðýmýz response, out multiple ise 3
% filtreyi uyguladýðýmýz response
[outSingle, outMultiple] = harrisDetect(image);

% Önce tek filtreyi uyguladýðýmýz resmi bastýrýyoruz.
figure('Name', 'Single Filter Applied');
imshow(image);
hold on;
for i = 1:300
    for j = 1:300
        if outSingle(i, j) > 0
            rectangle('Position',[j-4,i-4,8,8], 'EdgeColor', 'r');
        end
    end
end

%Sonra ise 3 filtreyi uyguladýðýmýz resmi bastýrýyoruz.
figure('Name', 'Multiple Filter Applied');
imshow(image);
hold on;
for i = 1:300
    for j = 1:300
        if outMultiple(i, j) > 0
            rectangle('Position',[j-4,i-4,8,8], 'EdgeColor', 'r');
        end
    end
end
