function edge_A = edge_sobel(binary_A)
    % Get the size of the binary input image
    [rows, cols] = size(binary_A);
    
    % Define the Sobel operator for horizontal and vertical edge detection
    sobel_h = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
    sobel_v = [-1, -2, -1; 0, 0, 0; 1, 2, 1];
    
    % Initialize the output edge image with zeros
    edge_A = zeros(rows, cols);
    
    % Perform convolution for horizontal and vertical edge detection
    for i = 2:(rows - 1)
        for j = 2:(cols - 1)
            % Calculate the horizontal gradient using Sobel operator
            gx = sum(sum(binary_A(i-1:i+1, j-1:j+1) .* sobel_h));
            
            % Calculate the vertical gradient using Sobel operator
            gy = sum(sum(binary_A(i-1:i+1, j-1:j+1) .* sobel_v));
            
            % Compute the gradient magnitude
            edge_A(i, j) = sqrt(gx^2 + gy^2);
        end
    end
    
    % Normalize the edge image to the range [0, 1]
    edge_A = edge_A / max(edge_A(:));
end
