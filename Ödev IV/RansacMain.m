numberOfPoints = 150;
numberOfIteration = 25;
screenSize = 10;

% Rasgele numberOfPoints deðiþkeni kadar nokta oluþturduk. screenSize x screenSize boyutunda bir
% ekran kullanýyoruz.
x = rand(1,numberOfPoints)*screenSize;
y = rand(1,numberOfPoints)*screenSize;

% Baþlangýçta en kýsa toplam mesafeyi sonsuz olarak alýyoruz. Her
% iterasyonda, daha kýsa bir mesafe bulursak bu deðeri güncelleyeceðiz
minDist = intmax('int64');

% Bu matris ise en kýsa mesafeye sahip 3 nokte çiftini, yani 3 doðruyu
% saklayan matris. Her satýrý 3 elemandan oluþuyor. Ýlk eleman bütün noktalarýn seçtiðimiz
% iki noktadan geçen doðruya uzaklýklarýnýn toplamý, diðer iki eleman ise
% bu doðruyu oluþturan noktalarýn koordinatlarý
minDistanceMatrix = [minDist 0 0;
                     minDist 0 0;
                     minDist 0 0];

%Nokta seçme iþlemini numberOfIteration kere tekrar edeceðiz
for j = 1:numberOfIteration
    % ilk rasgele noktamýzý seçiyoruz
    rand1 = randi(numberOfPoints);
    
    % ikinci rasgele noktamýzý seçiyoruz
    rand2 = randi(numberOfPoints);
    
    % bu iki noktadan geçen doðru denklemini oluþturuyoruz
    % bu denklem f(x) = ax + b þeklinde. a ve b deðerlerini aþaðýdaki gibi
    % hesaplýyoruz
    coefficients = polyfit([x(rand1), x(rand2)], [y(rand1), y(rand2)], 1);
    a = coefficients(1);
    b = coefficients(2);
    
    % Doðru denklemini oluþturduktan sonra konsola slope ve y-intercept'i yazdýrýyoruz. 
    Str = strcat('Slope:', num2str(a));
    disp(Str);
    
    Str = strcat('y-intercept:', num2str(b));
    disp(Str);
    
    % þimdi ise diðer noktalarýn bu doðruya uzaklýðýný bulacaðýz ve
    % toplayacaðýz. y=ax+b doðrusunu ax-y+b=0 formatýna getirip iþlemlerimizi
    % yapacaðýz.
    distance = 0;
    for i = 1:numberOfPoints
        distance = distance + abs(a*x(i)-y(i)+b)/sqrt(a*a+1);
    end
    
    % Her seferinde min uzaklýk deðerleri içindeki en büyük deðere
    % bakýyoruz. Eðer yeni hesapladýðýmýz deðer bu matrise girecekse,
    % matristeki mesafe deðerlerinin en büyüðünden daha küçük olmalý. 
    [maxVal, index] = max(minDistanceMatrix(:,1));
    
    % Karþýlaþtýrma yapýp matrisi güncelliyoruz.
    if distance < maxVal
        minDistanceMatrix(index,:) = [distance rand1 rand2];
    end
end

% Bütün iþlemler tamamlandý. Þimdi ise hesapladýðýmýz çizgileri noktalar
% ile birlikte ekrana çizdiriyoruz.
scatter(x,y);
hold on;
x1 = [x(minDistanceMatrix(1,2)) x(minDistanceMatrix(1,3))];
y1 = [y(minDistanceMatrix(1,2)) y(minDistanceMatrix(1,3))];

x2 = [x(minDistanceMatrix(2,2)) x(minDistanceMatrix(2,3))];
y2 = [y(minDistanceMatrix(2,2)) y(minDistanceMatrix(2,3))];

x3 = [x(minDistanceMatrix(3,2)) x(minDistanceMatrix(3,3))];
y3 = [y(minDistanceMatrix(3,2)) y(minDistanceMatrix(3,3))];

plot(x1, y1, x2, y2, x3, y3);
