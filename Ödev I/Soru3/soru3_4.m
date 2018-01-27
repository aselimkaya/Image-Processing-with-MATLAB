[vertexRight, face] = read_off('cow.off');
vertexLeft = vertexRight;

[x, y] = size(vertexRight);

translationM = [1, 0, 0, 1.25;
                0, 1, 0, 0;
                0, 0, 1, 0;
                0, 0, 0, 1];
focal = 15;
focalM =[focal, 0, 0, 0;
         0, focal, 0, 0; 
         0, 0, 1, 0];
            
for k = 1:y %sa� kamera i�in �nce translation daha sonra focal
    tempRight = cat(1, vertexRight(:,k), 1.0); % homojen koordinat olu�turuyoruz
    tempRight2 = translationM * tempRight;
    vertexRight(:,k) = focalM * tempRight2;
end

figure
scatter(vertexRight(1,:),vertexRight(2,:)); %sa� kamera i�in g�r�nt�

for m = 1:y % sol kamera i�in sadece focal
    tempLeft = cat(1, vertexLeft(:,k), 1.0);% homojen koordinat olu�turuyoruz
    vertexLeft(:,k) = focalM * tempLeft;
end

figure
scatter(vertexLeft(1,:),vertexLeft(2,:)); %sol kamera i�in g�r�nt�