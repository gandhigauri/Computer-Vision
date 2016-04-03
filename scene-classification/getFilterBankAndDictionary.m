function [filterBank, dictionary] = getFilterBankAndDictionary(image_names)
filterBank=createFilterBank();
filter_Responses=[];
a=50;
k=100;
for i=1:length(image_names)
    I=imread(image_names{i});
    if length(I(1,1,:))~=3
        I=repmat(I,[1,1,3]);
    end
    init_filterResponses=extractFilterResponses(I, filterBank);
    alpha=randperm(length(init_filterResponses(:,1)),a);
    filter_Responses=cat(1,filter_Responses,init_filterResponses(alpha,:));
end
[~,dictionary]=kmeans(filter_Responses,k,'EmptyAction','drop');
dictionary=dictionary';    
end
