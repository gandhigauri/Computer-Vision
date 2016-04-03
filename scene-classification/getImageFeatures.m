function [h] = getImageFeatures(wordMap, dictionarySize)
h=hist(wordMap(:),dictionarySize);
h=h'/sum(h');
end 