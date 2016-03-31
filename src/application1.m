clear;

% Read uncompressed image. 
image = imread('image/original.tif');
image = rgb2gray(image);

% Retrieve and plot first digit distribution.
stats = JPEGcoeffStats(image, getQuanMatrix(100));
figure, loglog(1 : 9, stats, 'r-*');
hold on;

% Repeat the process for compressed images.
for i = 50 : 10 : 90

    image = imread(['image/compress', num2str(i), '.jpg']);
    stats = JPEGcoeffStats(image, getQuanMatrix(100));
    loglog(1 : 9, stats, '-*');
    hold on;

end

image = imread(['image/compress', num2str(95), '.jpg']);
stats = JPEGcoeffStats(image, getQuanMatrix(100));
loglog(1 : 9, stats, '-*');
hold on;

image = imread(['image/compress', num2str(99), '.jpg']);
stats = JPEGcoeffStats(image, getQuanMatrix(100));
loglog(1 : 9, stats, '-*');
hold on;

legend('uncompressed', 'Q = 50', 'Q = 60', 'Q = 70', 'Q = 80', ...
            'Q = 90', 'Q = 95', 'Q = 99');
hold off;
