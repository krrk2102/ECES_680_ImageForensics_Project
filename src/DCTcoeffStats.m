function digitStats = DCTcoeffStats(image)

    blockSize = 8;
    [numRow, numCol] = size(image);
    
    image = double(image) - 128;
    image = blkproc(image, [blockSize blockSize], 'dct2(x)');
    
    digitStats = zeros(1, 10);
    
    for iBase = 1 : blockSize : numRow
        for jBase = 1 : blockSize : numCol
            
            for i = 1 : blockSize
                for j = 1 : blockSize
                    
                    if i ~= 1 || j ~= 1
                        
                        digit = getFirstDigit( ...
                            image(iBase + i - 1, jBase + j - 1)) + 1;
                        digitStats(1, digit) = digitStats(1, digit) + 1;
                        
                    end
                    
                end
            end
            
        end
    end
    
    digitStats = digitStats / sum(digitStats);

end

