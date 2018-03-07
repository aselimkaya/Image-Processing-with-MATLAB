function [ out ] = genislikArtir (image, pikselSayisi, operator)
for p = 1:pikselSayisi %kaç piksel artýracaksak döngü o kadar dönecek, her seferinde 1 piksel artacak
    [x, y] = size(image);
    
    if operator == 1 % hangi filtreyi uygulayacaðýmýzý seçiyoruz, enerji matrisini oluþturuyoruz
        Energy = ApplySobelFilter(double(image));
    else
        filter = create_log_filter(1.7, 5);
        Energy = ApplyLogFilter(double(image), filter, 5);
    end
    
    % yukarýdan aþaðýya doðru 3 komþuluk kullanarak (kenardaki pikseller
    % istisna, onlarda 2 komþuya baktýk) maximum path'i hesaplamaya çalýþýyoruz
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
    
    % bu aþamaya geldiðimizde yukarýdan aþaðýya doðru toplanarak hesaplanan
    % enerji deðerleri hesaplandý
    
    % her aþamada resmimize yeni bir sütun eklenecek. burada o iþlemi
    % gerçekleþtiryoruz
    temp = zeros(x,1);
    image = [image temp];
    
    % en alt satýrdaki maximum deðeri seçiyoruz. bu bize path'in en son
    % pikselini verecek
    [~, column] = max(Energy(x,:));
    
    % bu pikselden itibaren komþuluklara bakarak buraya nasýl geldiðimizi
    % hesaplýyoruz. Path'i oluþturan her bir pikseli yinelemek için
    % kaydýrma iþlemi yapýyoruz
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
    
    % en üst satýr için kaydýrma iþlemi yapýyoruz
    for n = y:-1:column
        image(1, n+1) = image(1, n);
    end
end

out = image;
end

