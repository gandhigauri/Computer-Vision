function [filterResponses] = extractFilterResponses(I, filterBank)
% CV Fall 2015 - Provided Code
% Extract the filter responses given the image and filter bank
% Pleae make sure the output format is unchanged. 
% Inputs: 
%   I:                  a 3-channel RGB image with width W and height H 
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W*H x N*3 matrix of filter responses
i=0; 
filteredImg=[];
concat_op=[];
%Convert input Image to Lab
doubleI = double(I);
[L,a,b] = RGB2Lab(doubleI(:,:,1), doubleI(:,:,2), doubleI(:,:,3));
lab=cat(3,L,a,b);
pixelCount = size(doubleI,1)*size(doubleI,2);
%filterResponses:    a W*H x N*3 matrix of filter responses
filterResponses = zeros(pixelCount, length(filterBank)*3);



%for each filter and channel, apply the filter, and vectorize

% === fill in your implementation here  ===
for i=1:20
    filteredImg=imfilter(lab,filterBank{i},'symmetric');
    concat_op=cat(2,concat_op,reshape(filteredImg,[pixelCount 3]));
end
filterResponses=concat_op;


end
