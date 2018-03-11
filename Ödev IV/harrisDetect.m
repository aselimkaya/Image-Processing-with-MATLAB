function [ out3, outMultiple ] = harrisDetect( image )

if size(image,3)==3
    image = rgb2gray(image);
end

IxFilter3 = [-1 0 1];
IyFilter3 = [-1; 0; 1];

IxMatrix3 = ApplyFilter1(double(image), IxFilter3, 3, 0);
IyMatrix3 = ApplyFilter1(double(image), IyFilter3, 3, 1);

out3 = ApplyFilter2(double(image), 3, IxMatrix3, IyMatrix3, 0.04);

IxFilter5 = [-1 -2 0 2 1];
IyFilter5 = [-1; -2; 0; 2; 1];

IxMatrix5 = ApplyFilter1(double(image), IxFilter5, 5, 0);
IyMatrix5 = ApplyFilter1(double(image), IyFilter5, 5, 1);

out5 = ApplyFilter2(double(image), 5, IxMatrix5, IyMatrix5, 0.04);

IxFilter7 = [-1 -2 -3 0 3 2 1];
IyFilter7 = [-1; -2; -3; 0; 3; 2; 1];

IxMatrix7 = ApplyFilter1(double(image), IxFilter7, 7, 0);
IyMatrix7 = ApplyFilter1(double(image), IyFilter7, 7, 1);

out7 = ApplyFilter2(double(image), 7, IxMatrix7, IyMatrix7, 0.04);

[x, y] = size(out3);

outMultiple = zeros(x, y);

for i = 1:x
    for j = 1:y
        % 3 filtreden birinde kenar olarak bulduysak yeni matriste de kenar
        % olarak işaretliyoruz
        if (out3(i,j) > 0) || (out5(i,j) > 0) || (out7(i,j) > 0)
            outMultiple(i,j) = 255;
        end
    end
end

end

