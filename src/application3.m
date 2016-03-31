clear;

image = imread('image/original.tif');
image = rgb2gray(image);

% Single compression.
figure;
for quality = 50 : 10 : 100
    
    fileLen = myOwnJPGEncoder(image, getQuanMatrix(quality));
    stats = directJPEGcoeff();
    loglog(1 : 9, stats, '-*');
    hold on;
    
end

legend('Q = 50', 'Q = 60', 'Q = 70', 'Q = 80', 'Q = 90', 'Q = 100');
hold off;

% Double compression.
figure;
for quality = 60 : 10 : 100
    
    % Compress image with current quality factor.
    fileLen = myOwnJPGEncoder(image, getQuanMatrix(quality));
    tmpImage = myOwnJPGDecoder();
    % Recompress image with lower quality factor by 10.
    fileLen = myOwnJPGEncoder(tmpImage, getQuanMatrix(quality - 10));
    stats = directJPEGcoeff();
    loglog(0 : 9, stats, '-*');
    hold on;
    
end

legend('Q1 = 60, Q2 = 50', 'Q1 = 70, Q2 = 60', 'Q1 = 80, Q2 = 70', ...
            'Q1 = 90, Q2 = 80', 'Q1 = 100, Q2 = 90');
hold off;
