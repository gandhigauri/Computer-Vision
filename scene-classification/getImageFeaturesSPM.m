function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
layer=layerNum-1;
l=0;
temp=[];
height=size(wordMap,1);
width=size(wordMap,2);
h=[];
for l=layer:-1:0
    if mod(height,2^l)~=0
        adj_height=ceil(height/2^l)*2^l;
    else
        adj_height=height;
    end
    if mod(width,2^l)~=0
        adj_width=ceil(width/2^l)*2^l;
    else
        adj_width=width;
    end
    adj_wordMap=padarray(wordMap,[adj_height-height adj_width-width],0,'post');
    fun = @(block_struct) getImageFeatures(block_struct.data, dictionarySize);
    B=blockproc(adj_wordMap,[adj_height/2^l adj_width/2^l],fun);
    if l==1 || l==0 
        temp=B(:)/(2^layer);
    else
        temp=B(:)*(2^(l-layer-1));
    end
    h=cat(1,h,temp);
end
end