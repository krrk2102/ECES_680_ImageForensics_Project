function digitStats = JPEGcoeffStats(image, quaMatrix)
% Input
%     image: input image bitmap in gray scale
%     quaMatrix: input JPEG quantization table
% Return
%     digitStats: first digit distributions
%                 of JPEG coefficients

    % Get size information.
    blockSize = 8;
    [numRow, numCol] = size(image);
              
    % Perform DCT transform and quantization. 
    image = double(image) - 128;
    image = blkproc(image, [blockSize blockSize], ...
                                        'dct2(x)');
    image = blkproc(image, [blockSize blockSize], ...
                                        'round(x./P1)', quaMatrix);
    
    digitStats = zeros(1, 9);
    % Get distribution of JPEG coefficients.
    for i = 1 : numRow
        for j = 1 : numCol 
            
            % Skip DC components.
            if (rem(i - 1, 8) ~= 0 || rem(j - 1, 8) ~= 0) && ...
                        image(i, j) ~= 0

                digit = getFirstDigit(image(i, j));
                digitStats(1, digit) = digitStats(1, digit) + 1;

            end
            
        end
    end
    
    % Calculate average / probability. 
    digitStats = digitStats ./ sum(digitStats);
    
end

