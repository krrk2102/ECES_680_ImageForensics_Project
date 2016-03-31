function fileLen = myOwnJPGEncoder(image, YTable)

    blockSize = 8;
    [row, col] = size(image);
    % Performing DCT by 8 * 8 block
    image = double(image) - 128;
    image = blkproc(image, [blockSize blockSize], 'dct2(x)');
    quaMatrix = YTable;
    % Performing quantization
    image = blkproc(image, [blockSize blockSize],'round(x./P1)', quaMatrix);

    newRow = row * col / (blockSize * blockSize);
    Y = ones(newRow, blockSize * blockSize);
    k = 1;
    % Zigzag image
    for i = 1 : blockSize : row
        for j = 1 : blockSize : col
            Y(k, :) = ZigzagMtx2Vector(image(i : i+blockSize-1, j : j+blockSize-1));
            k = k + 1;
        end
    end 

    % Entropy encoding
    fileLen = JPEG_entropy_encode(row, col, blockSize, quaMatrix, Y, '', 1);

end

