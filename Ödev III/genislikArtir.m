function [ out ] = genislikArtir (image, pikselSayisi, operator)
for p = 1:pikselSayisi %ka� piksel art�racaksak d�ng� o kadar d�necek, her seferinde 1 piksel artacak
    [x, y] = size(image);
    
    if operator == 1 % hangi filtreyi uygulayaca��m�z� se�iyoruz, enerji matrisini olu�turuyoruz
        Energy = ApplySobelFilter(double(image));
    else
        filter = create_log_filter(1.7, 5);
        Energy = ApplyLogFilter(double(image), filter, 5);
    end
    
    % yukar�dan a�a��ya do�ru 3 kom�uluk kullanarak (kenardaki pikseller
    % istisna, onlarda 2 kom�uya bakt�k) maximum path'i hesaplamaya �al���yoruz
    for i = 2:x
        for j = 1:y
            if j == 1
                Energy(i, j) = Energy(i, j) + max([ Energy(i-1, j), Energy(i-1, j+1) ]);
            elseif j == y
                Energy(i, j) = Energy(i, j) + max([ Energy(i-1, j-1), Energy(i-1, j) ]);
            else
                Energy(i, j) = Energy(i, j) + max([ Energy(i-1, j-1), Energy(i-1, j), Energy(i-1, j+1) ]);
            end
        end
    end
    
    % bu a�amaya geldi�imizde yukar�dan a�a��ya do�ru toplanarak hesaplanan
    % enerji de�erleri hesapland�
    
    % her a�amada resmimize yeni bir s�tun eklenecek. burada o i�lemi
    % ger�ekle�tiryoruz
    temp = zeros(x,1);
    image = [image temp];
    
    % en alt sat�rdaki maximum de�eri se�iyoruz. bu bize path'in en son
    % pikselini verecek
    [~, column] = max(Energy(x,:));
    
    % bu pikselden itibaren kom�uluklara bakarak buraya nas�l geldi�imizi
    % hesapl�yoruz. Path'i olu�turan her bir pikseli yinelemek i�in
    % kayd�rma i�lemi yap�yoruz
    for m = x:-1:2
        for n = y:-1:column
            image(m, n+1) = image(m, n);
        end
        
        if column == 1
            [~, column] =  max ([ Energy(m-1, column), Energy(m-1, column+1) ]);
        elseif column == y
            [~, column] = max ([ Energy(m-1, column-1), Energy(m-1, column) ]);
        else
            [~, column] = max ([ Energy(m-1, column-1), Energy(m-1, column), Energy(m-1, column+1) ]);
        end
    end
    
    % en �st sat�r i�in kayd�rma i�lemi yap�yoruz
    for n = y:-1:column
        image(1, n+1) = image(1, n);
    end
end

out = image;
end

