clear all

filterBank=createFilterBank();
%computeDictionary;
load('dictionary.mat');
load('../dat/traintest.mat'); 
i=0;
layerNum=3;
L=layerNum-1;
dictsize=size(dictionary,2);
dim=(dictsize*((4^(L+1))-1))/3;
allHist = zeros(dim,size(train_imagenames,2));

for i=1:size(train_imagenames,2)
    I=imread(strcat('../dat/',train_imagenames{i}));
    wordMap = getVisualWords(I, filterBank, dictionary);
    wordHist = getImageFeaturesSPM(layerNum, wordMap, dictsize);
    allHist(:,i)=wordHist;
end

train_features = allHist;

save('vision.mat','filterBank','dictionary','train_features', 'train_labels'); 


