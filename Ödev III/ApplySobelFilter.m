function [ imOut ] = ApplySobelFilter( im )

im = padarray(im,[1 1]);

[x, y] = size(im);

Gx = [-1 0 1;
      -2 0 2;
      -1 0 1];

Gx_edIm = zeros(x,y);
    
%Gx filtresi uyguluyoruz
    for i = 2:(x-1)
        for j = 2:(y-1)
            temp = 0;
            
            for k = -1:1
                for m = -1:1
                    temp = temp + (Gx(k+2, m+2)*im(i+k, j+m));
                end
            end
            temp = temp/9;
            Gx_edIm(i,j) = temp;
        end
    end
    
    Gy = [1 2 1;
      0 0 0;
     -1 -2 -1];
 
    Gy_edIm = zeros(x,y);
    
    %Gy filtresi uyguluyoruz
    for i = 2:(x-1)
        for j = 2:(y-1)
            temp = 0;
            
            for k = -1:1
                for m = -1:1
                    temp = temp + (Gy(k+2, m+2)*im(i+k, j+m));
                end
            end
            temp = temp/9;
            Gy_edIm(i,j) = temp;
        end
    end
    
    imOut = zeros(x,y);

    %karelerinin toplamýnýn karekökünü buluyoruz
    for i = 1:x
        for j = 1:y
            a = Gx_edIm(i,j);
            b = Gy_edIm(i,j);
            imOut(i,j) = sqrt(a*a + b*b);
        end
    end
    
    imOut = imOut(2:x-1, 2:y-1);
end

