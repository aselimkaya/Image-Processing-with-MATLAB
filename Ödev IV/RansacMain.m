numberOfPoints = 150;
numberOfIteration = 25;
screenSize = 10;

% Rasgele numberOfPoints de�i�keni kadar nokta olu�turduk. screenSize x screenSize boyutunda bir
% ekran kullan�yoruz.
x = rand(1,numberOfPoints)*screenSize;
y = rand(1,numberOfPoints)*screenSize;

% Ba�lang��ta en k�sa toplam mesafeyi sonsuz olarak al�yoruz. Her
% iterasyonda, daha k�sa bir mesafe bulursak bu de�eri g�ncelleyece�iz
minDist = intmax('int64');

% Bu matris ise en k�sa mesafeye sahip 3 nokte �iftini, yani 3 do�ruyu
% saklayan matris. Her sat�r� 3 elemandan olu�uyor. �lk eleman b�t�n noktalar�n se�ti�imiz
% iki noktadan ge�en do�ruya uzakl�klar�n�n toplam�, di�er iki eleman ise
% bu do�ruyu olu�turan noktalar�n koordinatlar�
minDistanceMatrix = [minDist 0 0;
                     minDist 0 0;
                     minDist 0 0];

%Nokta se�me i�lemini numberOfIteration kere tekrar edece�iz
for j = 1:numberOfIteration
    % ilk rasgele noktam�z� se�iyoruz
    rand1 = randi(numberOfPoints);
    
    % ikinci rasgele noktam�z� se�iyoruz
    rand2 = randi(numberOfPoints);
    
    % bu iki noktadan ge�en do�ru denklemini olu�turuyoruz
    % bu denklem f(x) = ax + b �eklinde. a ve b de�erlerini a�a��daki gibi
    % hesapl�yoruz
    coefficients = polyfit([x(rand1), x(rand2)], [y(rand1), y(rand2)], 1);
    a = coefficients(1);
    b = coefficients(2);
    
    % Do�ru denklemini olu�turduktan sonra konsola slope ve y-intercept'i yazd�r�yoruz. 
    Str = strcat('Slope:', num2str(a));
    disp(Str);
    
    Str = strcat('y-intercept:', num2str(b));
    disp(Str);
    
    % �imdi ise di�er noktalar�n bu do�ruya uzakl���n� bulaca��z ve
    % toplayaca��z. y=ax+b do�rusunu ax-y+b=0 format�na getirip i�lemlerimizi
    % yapaca��z.
    distance = 0;
    for i = 1:numberOfPoints
        distance = distance + abs(a*x(i)-y(i)+b)/sqrt(a*a+1);
    end
    
    % Her seferinde min uzakl�k de�erleri i�indeki en b�y�k de�ere
    % bak�yoruz. E�er yeni hesaplad���m�z de�er bu matrise girecekse,
    % matristeki mesafe de�erlerinin en b�y���nden daha k���k olmal�. 
    [maxVal, index] = max(minDistanceMatrix(:,1));
    
    % Kar��la�t�rma yap�p matrisi g�ncelliyoruz.
    if distance < maxVal
        minDistanceMatrix(index,:) = [distance rand1 rand2];
    end
end

% B�t�n i�lemler tamamland�. �imdi ise hesaplad���m�z �izgileri noktalar
% ile birlikte ekrana �izdiriyoruz.
scatter(x,y);
hold on;
x1 = [x(minDistanceMatrix(1,2)) x(minDistanceMatrix(1,3))];
y1 = [y(minDistanceMatrix(1,2)) y(minDistanceMatrix(1,3))];

x2 = [x(minDistanceMatrix(2,2)) x(minDistanceMatrix(2,3))];
y2 = [y(minDistanceMatrix(2,2)) y(minDistanceMatrix(2,3))];

x3 = [x(minDistanceMatrix(3,2)) x(minDistanceMatrix(3,3))];
y3 = [y(minDistanceMatrix(3,2)) y(minDistanceMatrix(3,3))];

plot(x1, y1, x2, y2, x3, y3);
