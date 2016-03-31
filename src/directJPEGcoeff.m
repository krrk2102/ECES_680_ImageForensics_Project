function digitStats = directJPEGcoeff()

    % Recover zigzag image from entropy decoder
    [numRow,numCol,blockSize,~,zImage] = JPEG_entropy_decode('');  
    image = ones(numRow, numCol);
    rowIndex = 1;
    colIndex = 1;
    % Recover image from zigzaged image
    for i = 1 : size(zImage, 1)
        image(rowIndex : rowIndex+blockSize-1, colIndex : colIndex+blockSize-1) = Vector2ZigzagMtx(zImage(i, :));
        colIndex = colIndex + blockSize;
        if colIndex > numCol
            colIndex = 1;
            rowIndex = rowIndex + blockSize;
        end
    end
    
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

