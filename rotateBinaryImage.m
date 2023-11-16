function rotatedImage = rotateBinaryImage(binaryImage, angle)
    angle = deg2rad(angle);
    [rows, cols] = size(binaryImage);
    newRows = ceil(rows * abs(cos(angle)) + cols * abs(sin(angle)));
    newCols = ceil(rows * abs(sin(angle)) + cols * abs(cos(angle)));

    rotatedImage = zeros(newRows, newCols);
    centerX = newCols / 2;
    centerY = newRows / 2;

    originalCenterX = (cols + 1) / 2;
    originalCenterY = (rows + 1) / 2;

    for i = 1:newRows
        for j = 1:newCols
            x = (j - centerX) * cos(angle) + (i - centerY) * sin(angle) + originalCenterX;
            y = -(j - centerX) * sin(angle) + (i - centerY) * cos(angle) + originalCenterY;

            if x >= 1 && x <= cols && y >= 1 && y <= rows
                x1 = floor(x);
                x2 = ceil(x);
                y1 = floor(y);
                y2 = ceil(y);

                value1 = binaryImage(y1, x1);
                value2 = binaryImage(y1, x2);
                value3 = binaryImage(y2, x1);
                value4 = binaryImage(y2, x2);

                x_fraction = x - x1;
                y_fraction = y - y1;

                rotatedImage(i, j) = (1 - x_fraction) * (1 - y_fraction) * value1 + x_fraction * (1 - y_fraction) * value2 + (1 - x_fraction) * y_fraction * value3 + x_fraction * y_fraction * value4;
            end
        end
    end

    rotatedImage = rotatedImage > 0.5;
end
