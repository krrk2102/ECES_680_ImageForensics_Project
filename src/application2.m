clear;

for quality = 50 : 10 : 90
    % Pick a compressed image with current quality factor.
    image = imread(['image/compress', num2str(quality),'.jpg']);

    figure;
    for i = 50 : 10 : 100
        % Retrieve distribution under compression with new quality factor.
        stats = JPEGcoeffStats(image, getQuanMatrix(i));
        loglog(1 : 9, stats, '-*');
        hold on;

    end

    legend('Q = 50', 'Q = 60', 'Q = 70', 'Q = 80', 'Q = 90', 'Q = 100');
    hold off;

end