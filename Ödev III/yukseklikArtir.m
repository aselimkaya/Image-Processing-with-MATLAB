function [ out ] = yukseklikArtir(image, pikselSayisi, operator)
for p = 1:pikselSayisi %ka� piksel art�racaksak d�ng� o kadar d�necek, her seferinde 1 piksel artacak
    [x, y] = size(image);
    
    if operator == 1 % hangi filtreyi uygulayaca��m�z� se�iyoruz, enerji matrisini olu�turuyoruz
        Energy = ApplySobelFilter(double(image));
    else
        filter = create_log_filter(1.7, 5);
        Energy = ApplyLogFilter(double(image), filter, 5);
    end
    
    
    % soldan sa�a do�ru 3 kom�uluk kullanarak (kenardaki pikseller
    % istisna, onlarda 2 kom�uya bakt�k) maximum path'i hesaplamaya �al���yoruz
    for i = 2:y
        for j = 1:x
            if j == 1
                Energy(j, i) = Energy(j, i) + max([ Energy(j, i-1), Energy(j+1, i-1) ]);
            elseif j == x
                Energy(j, i) = Energy(j, i) + max([ Energy(j-1, i-1), Energy(j, i-1) ]);
            else
                Energy(j, i) = Energy(j, i) + max([ Energy(j-1, i-1), Energy(j, i-1), Energy(j+1, i-1) ]);
            end
        end
    end
    
    % bu a�amaya geldi�imizde soldan sa�a do�ru toplanarak hesaplanan
    % enerji de�erleri hesapland�
    
    % her a�amada resmimize yeni bir sat�r eklenecek. burada o i�lemi
    % ger�ekle�tiryoruz
    temp = zeros(1,y);
    image = [image; temp];
    
    % en sa� s�tundaki max de�eri se�iyoruz. bu bize path'in en son
    % pikselini verecek
    [~, row] = max(Energy(:,y));
    
    % bu pikselden itibaren kom�uluklara bakarak buraya nas�l geldi�imizi
    % hesapl�yoruz. Path'i olu�turan her bir pikseli yinelemek i�in
    % kayd�rma i�lemi yap�yoruz
    for m = y:-1:2
        for n = x:-1:row
            image(n+1, m) = image(n, m);
        end
        
        if row == 1
            [~, row] =  max([ Energy(row, m-1), Energy(row+1, m-1) ]);
        elseif row == x
            [~, row] = max([ Energy(row-1, m-1), Energy(row, m-1) ]);
        else
            [~, row] = max([ Energy(row-1, m-1), Energy(row, m-1), Energy(row+1, m-1) ]);
        end
    end
    
    % en �st sat�r i�in kayd�rma i�lemi yap�yoruz
    for n = x:-1:row
        image(n+1, m) = image(n, m);
    end
end

out = image;
end

