function [ im ] = convolutional_filter( mask, im )
    mask = fliplr(mask);
    mask = flipud(mask);
    
    im = padarray(im,[7 7],0,'both');
    
    [x, y] = size(im);
    
    for i = 8:(x-7)
        for j = 8:(y-7)
            temp = 0;
            
            for k = -7:7
                for m = -7:7
                    temp = temp + (mask(k+8, m+8)*im(i+k, j+m));
                end
            end
            temp = temp/255;
            im(i,j) = temp;
        end
    end
    im = im(8:x-7, 8:y-7);
end

