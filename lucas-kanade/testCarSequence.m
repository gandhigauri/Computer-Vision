tic;
load(fullfile('..','data','carseq.mat')); % variable name = frames. 
n=size(frames,3);
rects=zeros([n 4]);
rect=[60,117,146,152];
rects(1,:)=rect;
width=abs(rect(1)-rect(3));
height=abs(rect(2)-rect(4));
for i=1:n-1
    if i==1 || i==100 || i==200 || i==300 || i==400
        figure
        imshow(im2double(frames(:,:,i)));
        str = sprintf('%f (%f seconds)',i,toc);
        title(str);
        hold on;
        rectangle('position',[rect(1) rect(2) width height],'EdgeColor','y');
        %hold off;
        %pause(0.001);
        
    end
    [u,v]=LucasKanade(frames(:,:,i),frames(:,:,i+1),rect);
    rect=[rect(1)+u rect(2)+v rect(3)+u rect(4)+v];
    rect=round(rect);
    rects(i+1,:)=rect;
end
% save the rects
save(fullfile('..','results','carseqrects.mat'),'rects');
