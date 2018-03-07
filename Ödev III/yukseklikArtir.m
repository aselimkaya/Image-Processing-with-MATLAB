function [ out ] = yukseklikArtir(image, pikselSayisi, operator)
for p = 1:pikselSayisi %kaç piksel artýracaksak döngü o kadar dönecek, her seferinde 1 piksel artacak
    [x, y] = size(image);
    
    if operator == 1 % hangi filtreyi uygulayacaðýmýzý seçiyoruz, enerji matrisini oluþturuyoruz
        Energy = ApplySobelFilter(double(image));
    else
        filter = create_log_filter(1.7, 5);
        Energy = ApplyLogFilter(double(image), filter, 5);
    end
    
    
    % soldan saða doðru 3 komþuluk kullanarak (kenardaki pikseller
    % istisna, onlarda 2 komþuya baktýk) maximum path'i hesaplamaya çalýþýyoruz
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
    
    % bu aþamaya geldiðimizde soldan saða doðru toplanarak hesaplanan
    % enerji deðerleri hesaplandý
    
    % her aþamada resmimize yeni bir satýr eklenecek. burada o iþlemi
    % gerçekleþtiryoruz
    temp = zeros(1,y);
    image = [image; temp];
    
    % en sað sütundaki max deðeri seçiyoruz. bu bize path'in en son
    % pikselini verecek
    [~, row] = max(Energy(:,y));
    
    % bu pikselden itibaren komþuluklara bakarak buraya nasýl geldiðimizi
    % hesaplýyoruz. Path'i oluþturan her bir pikseli yinelemek için
    % kaydýrma iþlemi yapýyoruz
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
    
    % en üst satýr için kaydýrma iþlemi yapýyoruz
    for n = x:-1:row
        image(n+1, m) = image(n, m);
    end
end

out = image;
end

