clear;
close all;
%%
inputImage = imread('hello_world.jpg'); 
%divide
[rows, cols, ~] = size(inputImage);
third = floor(rows / 3);
subImage = inputImage((third + 1):(2 * third), :, :);
imwrite(subImage, 'subImage.jpg');
%rgb to gray
gray_A = my_rgb2gray(subImage);
%%
figure;
subplot(3,2,1);
imshow(gray_A, []);
title('gray');
hold on;

% Binarize
subplot(3,2,2);
threshold = otsuThreshold(gray_A) + 50;%otsu
binary_A = gray_A < threshold;
binary_A(:, 1:6) = 1;%denoise
imshow(binary_A,[]);
title('binary');

% Edge
subplot(3,2,3);
%edge_A = edge(binary_A, 'sobel');
edge_A = edge_sobel(binary_A);
edge_A = ~edge_A;
imshow(edge_A,[]);
title('edge');

%thin
subplot(3,2,4);
thin_A = thin(binary_A);
imshow(thin_A, []);
title('thin');

%label
bw = ~binary_A | ~edge_A;
% [L,num] = bwlabel(bw,8);
[L,num] = label_image(bw,8);
RGB = label2rgb(L);
subplot(3,2,5),imshow(RGB),title('label')
%% segment
num_images = 10; 
output_folder = 'output'; 
seg_A = thin_A;
%seg_A = binary_A;

if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

center_row = round(size(seg_A, 1) / 2 - 5);
image_count = 0;

col = 1; 
while col <= size(seg_A, 2) && image_count < num_images
    if seg_A(center_row, col) == 0
        start_col = col - 4;
        end_col = min(start_col + 33, size(seg_A, 2));
        cropped_image = seg_A(:, start_col:end_col);
        
        % 在图像数据的左侧添加10列白色像素
        cropped_image = [ones(size(cropped_image, 1), 20) cropped_image];
        % 在图像数据的右侧添加10列白色像素
        cropped_image = [cropped_image ones(size(cropped_image, 1), 20)];

        output_filename = fullfile(output_folder, sprintf('output%d.jpg', image_count + 1));
        imwrite(cropped_image, output_filename);
        
        image_count = image_count + 1;
        
        col = end_col + 1;
    else
        col = col + 1;
    end
end


