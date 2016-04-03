load(fullfile('..','data','aerialseq.mat'));
n=size(frames,3);
for i=1:n-1
    mask=SubtractDominantMotion(frames(:,:,i),frames(:,:,i+1));
    fused_img=imfuse(frames(:,:,i),mask);
    if i==30 || i==60 || i==90 || i==120
        figure
        imshow(fused_img);
        str = sprintf('%f',i);
        title(str);
    end
end
%save(fullfile('..','results','aerialseqrects.mat','rects'));
