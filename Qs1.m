
%Group1 CA Project1

clear;
close all;
%%
fid = fopen("ME5405_Group1\chromo.txt");

lf = newline;
cr = char(13);

A = fscanf(fid,[cr lf '%c'],[64,64]);
fclose(fid);
A = A';
%denoise
A(:, 1:6) = 32;

A(isletter(A))= A(isletter(A)) - 55;
A(A >= '0' & A <= '9') = A(A >= '0' & A <= '9') - 48;
gray_A = uint8(A);
%%
figure;
subplot(3,2,1);
imshow(gray_A, []);
title('gray');
hold on;

%% Binarize
subplot(3,2,2);
threshold = otsuThreshold(gray_A);%otsu
binary_A = gray_A > threshold;
imshow(binary_A,[]);
title('binary');

%% rotate
subplot(3,2,3);
rotate_A = rotateBinaryImage(binary_A,90);%the second parameter is rotate angle
imshow(rotate_A,[]);
title('rotate');

%% Edge
subplot(3,2,4);
edge_A = edge(binary_A, 'sobel');
%edge_A = edge_sobel(binary_A);
edge_A = ~edge_A;
imshow(edge_A,[]);
title('edge');
%% thin
subplot(3,2,5);
thin_A = thin(binary_A);
imshow(thin_A, []);
title('thin');
%% label
bw = ~binary_A | ~edge_A;
% [L,num] = bwlabel(bw,8);
[L,num] = label_image(bw,8);
RGB = label2rgb(L);
subplot(3,2,6),imshow(RGB),title('label')


