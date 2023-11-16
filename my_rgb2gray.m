function grayImage = my_rgb2gray(rgbImage)
    [rows, cols, ~] = size(rgbImage);
    grayImage = zeros(rows, cols);
    
    for row = 1:rows
        for col = 1:cols
            red = double(rgbImage(row, col, 1));
            green = double(rgbImage(row, col, 2));
            blue = double(rgbImage(row, col, 3));
            
            grayValue = round(0.2989 * red + 0.5870 * green + 0.1140 * blue);
            grayImage(row, col) = grayValue;
        end
    end
end
