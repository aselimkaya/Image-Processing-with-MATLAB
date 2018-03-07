function [ out ] = genislikAzalt (image, pikselSayisi, operator)

for p = 1:pikselSayisi %ka� piksel azaltacaksak d�ng� o kadar d�necek, her seferinde 1 piksel azalacak
    [x, y] = size(image);
    
    if operator == 1 % hangi filtreyi uygulayaca��m�z� se�iyoruz, enerji matrisini olu�turuyoruz
        Energy = ApplySobelFilter(double(image));
    else
        filter = create_log_filter(1.7, 5);
        Energy = ApplyLogFilter(double(image), filter, 5);
    end
    
    % yukar�dan a�a��ya do�ru 3 kom�uluk kullanarak (kenardaki pikseller
    % istisna, onlarda 2 kom�uya bakt�k) minimum path'i hesaplamaya �al���yoruz
    for i = 2:x
        for j = 1:y
            if j == 1
                Energy(i, j) = Energy(i, j) + min([ Energy(i-1, j), Energy(i-1, j+1) ]);
            elseif j == y
                Energy(i, j) = Energy(i, j) + min([ Energy(i-1, j-1), Energy(i-1, j) ]);
            else
                Energy(i, j) = Energy(i, j) + min([ Energy(i-1, j-1), Energy(i-1, j), Energy(i-1, j+1) ]);
            end
        end
    end
    
    % bu a�amaya geldi�imizde yukar�dan a�a��ya do�ru toplanarak hesaplanan
    % enerji de�erleri hesapland�
    
    % en alt sat�rdaki minimum de�eri se�iyoruz. bu bize path'in en son
    % pikselini verecek
    [~, column] = min(Energy(x,:));
    
    % bu pikselden itibaren kom�uluklara bakarak buraya nas�l geldi�imizi
    % hesapl�yoruz. Path'i olu�turan her bir pikseli resimden ��karmak i�in
    % kayd�rma i�lemi yap�yoruz
    for m = x:-1:2
        for n = column:y-1
            image(m, n) = image(m, n+1);
        end
        
        if column == 1
            [~, column] =  min ([ Energy(m-1, column), Energy(m-1, column+1) ]);
        elseif column == y
            [~, column] = min ([ Energy(m-1, column-1), Energy(m-1, column) ]);
        else
            [~, column] = min ([ Energy(m-1, column-1), Energy(m-1, column), Energy(m-1, column+1) ]);
        end
    end
    
    % en �st sat�r i�in kayd�rma i�lemi yap�yoruz
    for n = column:y-1
        image(1, n) = image(1, n+1);
    end
    
    % sola do�ru kayd�rma yapt���m�z i�in en sa�daki column art�k i�levsiz. onu
    % ana resimden ��kar�yoruz
    image = image(1:x,1:y-1);
end

out = image;
end

