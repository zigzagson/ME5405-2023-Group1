%% load file
path_train = '..\p_dataset_26';
imds_train = imageDatastore(path_train,'IncludeSubfolders',true,'FileExtensions','.png',...
                            'LabelSource','foldernames');

path_train = '.\output (binary)';
imds_test = imageDatastore(path_train,'IncludeSubfolders',true,'FileExtensions','.jpg',...
                            'LabelSource','foldernames');

Train_disp = countEachLabel(imds_train);
disp(Train_disp);
%% 
img = readimage(imds_train, 1);

% Extract HOG features and HOG visualization
[hog_2x2, vis2x2] = extractHOGFeatures(img,'CellSize',[2 2]);
[hog_4x4, vis4x4] = extractHOGFeatures(img,'CellSize',[4 4]);
[hog_8x8, vis8x8] = extractHOGFeatures(img,'CellSize',[8 8]);

% Show the original image
figure; 
subplot(2,3,1:3); imshow(img);

% Visualize the HOG features
subplot(2,3,4);  
plot(vis2x2); 
title({'CellSize = [2 2]'; ['Length = ' num2str(length(hog_2x2))]});

subplot(2,3,5);
plot(vis4x4); 
title({'CellSize = [4 4]'; ['Length = ' num2str(length(hog_4x4))]});

subplot(2,3,6);
plot(vis8x8); 
title({'CellSize = [8 8]'; ['Length = ' num2str(length(hog_8x8))]});

cellSize = [8 8];
hogFeatureSize = length(hog_8x8);


%%
numImages = numel(imds_train.Files);
trainingFeatures = zeros(numImages,hogFeatureSize,'single');

for i = 1:numImages
    img = readimage(imds_train,i);
    
    img = im2gray(img);
    
    % Apply pre-processing steps
    img = imbinarize(img);
    
    trainingFeatures(i, :) = extractHOGFeatures(img,'CellSize',cellSize);  
end

% Get labels for each image.
trainingLabels = imds_train.Labels;


%% 
img = readimage(imds_test, 4);
    img = im2gray(img);
    
    % Apply pre-processing steps
    img = imbinarize(img);
% Extract HOG features and HOG visualization
[hog_2x2, vis2x2] = extractHOGFeatures(img,'CellSize',[2 2]);
[hog_4x4, vis4x4] = extractHOGFeatures(img,'CellSize',[4 4]);
[hog_8x8, vis8x8] = extractHOGFeatures(img,'CellSize',[8 8]);

% Show the original image
figure; 
subplot(2,3,1:3); imshow(img);

% Visualize the HOG features
subplot(2,3,4);  
plot(vis2x2); 
title({'CellSize = [2 2]'; ['Length = ' num2str(length(hog_2x2))]});

subplot(2,3,5);
plot(vis4x4); 
title({'CellSize = [4 4]'; ['Length = ' num2str(length(hog_4x4))]});

subplot(2,3,6);
plot(vis8x8); 
title({'CellSize = [8 8]'; ['Length = ' num2str(length(hog_8x8))]});
cellSize = [8 8];
hogFeatureSize = length(hog_8x8);
%%
numImages = numel(imds_test.Files);
testFeatures = zeros(numImages,hogFeatureSize,'single');

for i = 1:numImages
    img = readimage(imds_test,i);
    
    img = im2gray(img);
    
    % Apply pre-processing steps
    img = imbinarize(img);
    
    testFeatures(i, :) = extractHOGFeatures(img,'CellSize',cellSize);  
end
    testLabels = imds_test.Labels;



