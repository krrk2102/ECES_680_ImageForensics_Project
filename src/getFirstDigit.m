function digit = getFirstDigit(number)
% Input
%     number: input integer
% Return
%     digit: most significant digit of the number

    % Get absolute value in case of negative input
    number = abs(number);
    
    % Remove less significant digit.
    while number >= 10
        number = floor(number / 10);
    end
    
    % Round to integer value.
    digit = floor(number);

end

