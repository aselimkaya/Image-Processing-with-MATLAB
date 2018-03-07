function [ out ] = yukseklikAzalt(image, pikselSayisi, operator)
for p = 1:pikselSayisi %ka� piksel azaltacaksak d�ng� o kadar d�necek, her seferinde 1 piksel azalacak
    [x, y] = size(image);
    
    if operator == 1 % hangi filtreyi uygulayaca��m�z� se�iyoruz, enerji matrisini olu�turuyoruz
        Energy = ApplySobelFilter(double(image));
    else
        filter = create_log_filter(1.7, 5);
        Energy = ApplyLogFilter(double(im), filter, 5);
    end
    
    for i = 2:y
        for j = 1:x
            if j == 1
                Energy(j, i) = Energy(j, i) + min([ Energy(j, i-1), Energy(j+1, i-1) ]);
            elseif j == x
                Energy(j, i) = Energy(j, i) + min([ Energy(j-1, i-1), Energy(j, i-1) ]);
            else
                Energy(j, i) = Energy(j, i) + min([ Energy(j-1, i-1), Energy(j, i-1), Energy(j+1, i-1) ]);
            end
        end
    end
    
    % bu a�amaya geldi�imizde soldan sa�a do�ru toplanarak hesaplanan
    % enerji de�erleri hesapland�
    
    % en sa� s�tundaki minimum de�eri se�iyoruz. bu bize path'in en son
    % pikselini verecek
    [~, row] = min(Energy(:,y));
    
    % bu pikselden itibaren kom�uluklara bakarak buraya nas�l geldi�imizi
    % hesapl�yoruz. Path'i olu�turan her bir pikseli resimden ��karmak i�in
    % kayd�rma i�lemi yap�yoruz
    for m = y:-1:2
        for n = row:x-1
            image(n, m) = image(n+1, m);
        end
        
        if row == 1
            [~, row] =  min ([ Energy(row, m-1), Energy(row+1, m-1) ]);
        elseif row == x
            [~, row] = min ([ Energy(row-1, m-1), Energy(row, m-1) ]);
        else
            [~, row] = min ([ Energy(row-1, m-1), Energy(row, m-1), Energy(row+1, m-1) ]);
        end
    end
    
    % en sol s�tun i�in kayd�rma i�lemi yap�yoruz
    for n = row:x-1
        image(n, 1) = image(n+1, 1);
    end
    
    % yukar� do�ru kayd�rma yapt���m�z i�in en alttaki row art�k i�levsiz. onu
    % ana resimden ��kar�yoruz
    image = image(1:x-1,1:y);
end

out = image;
end

