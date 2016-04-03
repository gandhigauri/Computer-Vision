function [wordMap] = getVisualWords(I, filterBank, dictionary)
if length(I(1,1,:))~=3
    I=repmat(I,[1,1,3]);
end
wordMap=zeros(size(I));
filterResponses=extractFilterResponses(I, filterBank);
[Euc_dist,index]=pdist2(dictionary',filterResponses,'euclidean','Smallest',1);
wordMap=reshape(index,size(I,1),size(I,2));
end