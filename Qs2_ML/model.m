%% svm

[trainedClassifier, validationAccuracy] = svm_train(trainingFeatures, trainingLabels);
% 
% label=svmtestModel.predictFcn(testFeatures)
predictedLabels = trainedClassifier.predictFcn(testFeatures)

confMat = confusionmat(testLabels, predictedLabels);

%% knn

[trainedClassifier, validationAccuracy] = knncosineClassifier(trainingFeatures, trainingLabels)
predictedLabels = trainedClassifier.predictFcn(testFeatures)
% label=fineknnModel.predictFcn(testFeatures)
% label=cosineModel.predictFcn(testFeatures)

%% fine tree

[trainedClassifier, validationAccuracy] = tree_train(trainingFeatures, trainingLabels)
predictedLabels = trainedClassifier.predictFcn(testFeatures)
% label=treeModel.predictFcn(testFeatures)
