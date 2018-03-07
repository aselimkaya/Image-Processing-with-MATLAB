function [ out ] = yukseklikAzalt(image, pikselSayisi, operator)
for p = 1:pikselSayisi %kaç piksel azaltacaksak döngü o kadar dönecek, her seferinde 1 piksel azalacak
    [x, y] = size(image);
    
    if operator == 1 % hangi filtreyi uygulayacaðýmýzý seçiyoruz, enerji matrisini oluþturuyoruz
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
    
    % bu aþamaya geldiðimizde soldan saða doðru toplanarak hesaplanan
    % enerji deðerleri hesaplandý
    
    % en sað sütundaki minimum deðeri seçiyoruz. bu bize path'in en son
    % pikselini verecek
    [~, row] = min(Energy(:,y));
    
    % bu pikselden itibaren komþuluklara bakarak buraya nasýl geldiðimizi
    % hesaplýyoruz. Path'i oluþturan her bir pikseli resimden çýkarmak için
    % kaydýrma iþlemi yapýyoruz
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
    
    % en sol sütun için kaydýrma iþlemi yapýyoruz
    for n = row:x-1
        image(n, 1) = image(n+1, 1);
    end
    
    % yukarý doðru kaydýrma yaptýðýmýz için en alttaki row artýk iþlevsiz. onu
    % ana resimden çýkarýyoruz
    image = image(1:x-1,1:y);
end

out = image;
end

