[vertex, face] = read_off('cow.off');

figure
scatter3(vertex(1,:),vertex(2,:), vertex(3,:)); %Birinci þýkkýn çözümü

[x, y] = size(vertex);

rotationM = [0.9948391,-0.0821202,0.0595940;
             0.0912277,0.9810261,-0.1710711;
             -0.0444148,0.1756248,0.9834548];
focal = 15;
focalM =[focal, 0, 0, 0; 0, focal, 0, 0; 0, 0, 1, 0];

for k = 1:y
    vertex(:,k) = rotationM * vertex(:,k); %rotasyon matrisi ile çarptýk
    temp = cat(1, vertex(:,k), 1.0); % koordinatlarý homojen yaptýk
    vertex(:,k) = focalM * temp;
end

figure
scatter(vertex(1,:),vertex(2,:)); %Ýkinci þýkkýn çözümü