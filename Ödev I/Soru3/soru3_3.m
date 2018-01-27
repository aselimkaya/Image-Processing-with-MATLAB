[vertex, face] = read_off('cow.off');

[x, y] = size(vertex);

translationM = [1, 0, 0, 1.5;
                0, 1, 0, 0;
                0, 0, 1, 0.75;
                0, 0, 0, 1];
focal = 15;
focalM =[focal, 0, 0, 0;
         0, focal, 0, 0; 
         0, 0, 1, 0];
            
for k = 1:y % �nce translation sonra focal
    temp = cat(1, vertex(:,k), 1.0); % homojen koordinat olu�turuyoruz
    temp2 = translationM * temp;
    vertex(:,k) = focalM * temp2;
end

scatter(vertex(1,:),vertex(2,:));