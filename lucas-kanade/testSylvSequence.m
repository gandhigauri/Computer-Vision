load(fullfile('..','data','sylvseq.mat'));
load(fullfile('..','data','sylvbases.mat'));
%frames = frames(:,:,1:5:end);
n=size(frames,3);
rects=zeros([n 4]);
rect1=[102,62,156,108];
rect2=[102,62,156,108];
rects(1,:)=rect2;
width=abs(rect1(1)-rect1(3));
height=abs(rect1(2)-rect1(4));
for i=1:n-1
    if i==1 || i==100 || i==200 || i==300 || i==400
        figure
        imshow(im2double(frames(:,:,i)));
        str = sprintf('%f',i);
        title(str);
        hold on;
        rectangle('position',[rect2(1) rect2(2) width height],'EdgeColor','y');
        rectangle('position',[rect1(1) rect1(2) width height],'EdgeColor','g');
        %hold off;
        %pause(0.001);
        
    end
    [u1,v1]=LucasKanade(frames(:,:,i),frames(:,:,i+1),rect1);
    rect1=[rect1(1)+u1 rect1(2)+v1 rect1(3)+u1 rect1(4)+v1];
    rect1=round(rect1);
    [u2,v2]=LucasKanadeBasis(frames(:,:,i),frames(:,:,i+1),rect2,bases);
    rect2=[rect2(1)+u2 rect2(2)+v2 rect2(3)+u2 rect2(4)+v2];
    rect2=round(rect2);
    rects(i+1,:)=rect2;
end

save(fullfile('..','results','sylvseqrects.mat'), 'rects');
