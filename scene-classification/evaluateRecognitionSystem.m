load('../dat/traintest.mat');
load('vision.mat');
guessed_labels=zeros(1,160);
i=0;
fprintf('[Loading..]\n');
for i=1:size(test_imagenames,2)
    I=imread(strcat('../dat/',test_imagenames{i}));
    fprintf('[Getting Visual Words..]\n');
    wordMap = getVisualWords(I, filterBank, dictionary);
    h = getImageFeaturesSPM(3, wordMap, size(dictionary,2));
    distances = distanceToSet(h, train_features);
    [~,nnI] = max(distances);
    guessedImage = mapping{train_labels(nnI)};
    guessed_labels(i) = train_labels(nnI);
    %fprintf('[My Guess]:%s.\n',guessedImage);
end

[Conf,~]=confusionmat(test_labels,guessed_labels);

accuracy = (trace(Conf))/(sum(Conf(:)));