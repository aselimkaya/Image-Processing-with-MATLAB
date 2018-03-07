im = imread('Istanbul.jpg');
im = rgb2gray(im);

log_filter = create_log_filter(1.7, 5);

out = ApplyLogFilter(double(im), log_filter, 5);

out = mat2gray(out);

imshow(out);