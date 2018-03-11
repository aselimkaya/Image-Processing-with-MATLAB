function [ imOut ] = ApplyFilter2( im, dim, IxMatrix, IyMatrix, k )

intPart = fix(dim/2);

im = padarray(im,[intPart intPart]);
IxMatrix = padarray(IxMatrix,[intPart intPart]);
IyMatrix = padarray(IyMatrix,[intPart intPart]);

[x, y] = size(im);

imOut = zeros(x,y);

for i = intPart+1:(x-intPart)
    for j = intPart+1:(y-intPart)
        M = zeros(2,2);
        
        % Window function ile M matrisini çarpıyoruz
        for n = -1*intPart:intPart
            for m = -1*intPart:intPart
                Ix = IxMatrix(i+n, j+m);
                Iy = IyMatrix(i+n, j+m);
                M = M + (im(i+n, j+m) * [Ix*Ix Ix*Iy; Ix*Iy Iy*Iy]);
            end
        end
        M = M./dim*dim;
        trace = M(1,1)+M(2,2);
        % Mc değerini hesaplıyoruz
        imOut(i,j) = det(M)-k*trace*trace;
    end
end

imOut = imOut(intPart+1:(x-intPart), intPart+1:(y-intPart));

%Bulduğumuz değerleri 0-255 arasına scale ediyoruz
imOut = (255 * mat2gray(imOut));

% Matrisin ortalamasını hesaplıyoruz. Bu değerin %50 fazlasını treshold
% olarak kabul edip resme uyguluyoruz.
avg = mean2(imOut);
avg = avg + avg/2;

for m = 1:x-2*intPart
    for n = 1:y-2*intPart
        if imOut(m,n) > avg
            imOut (m,n) = 255;
        else
            imOut (m,n) = 0;
        end
    end
end

% Son olarak da non-maximum surpression işlemini yapıyoruz.
%imOut = imOut >= imdilate(imOut, [1 1 1; 1 0 1; 1 1 1]);

end

