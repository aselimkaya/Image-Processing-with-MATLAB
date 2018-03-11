function [ imOut ] = ApplyFilter1( im, filter, dim, mode )

intPart = fix(dim/2);

im = padarray(im,[intPart intPart]);

[x, y] = size(im);

imOut = zeros(x,y);

if mode == 0 % Ix 'i resme uyguluyoruz
    for i = intPart+1:(x-intPart)
        for j = intPart+1:(y-intPart)
            temp = 0;
            
            for m = -1*intPart:intPart
                temp = temp + (filter(1, m+intPart+1) * im(i, j+m));
            end
            
            temp = temp/dim*dim;
            imOut(i,j) = temp;
        end
    end
    
else % Iy 'i uyguluyoruz
    for i = intPart+1:(x-intPart)
        for j = intPart+1:(y-intPart)
            temp = 0;
            
            for m = -1*intPart:intPart
                temp = temp + (filter(m+intPart+1, 1) * im(i+m, j));
            end
            
            temp = temp/dim*dim;
            imOut(i,j) = temp;
        end
    end
end
imOut = imOut(intPart+1:(x-intPart), intPart+1:(y-intPart));
end
