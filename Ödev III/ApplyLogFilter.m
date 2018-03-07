function [ imOut ] = ApplyLogFilter( im, filter, dim )

intPart = fix(dim/2);

im = padarray(im,[intPart intPart]);

[x, y] = size(im);

imOut = zeros(x,y);
    
    for i = intPart+1:(x-intPart)
        for j = intPart+1:(y-intPart)
            temp = 0;
            
            for k = -1*intPart:intPart
                for m = -1*intPart:intPart
                    temp = temp + (filter(k+intPart+1, m+intPart+1)*im(i+k, j+m));
                end
            end
            temp = temp/dim*dim;
            imOut(i,j) = temp;
        end
    end
    
    imOut = imOut(intPart+1:(x-intPart), intPart+1:(y-intPart));
end

