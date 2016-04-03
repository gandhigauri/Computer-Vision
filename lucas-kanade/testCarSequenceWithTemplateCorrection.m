% Extra credit.  You can leave this untouched if you're not doing the EC.
load(fullfile('..','data','carseq.mat')); % variable name = frames. 
n=size(frames,3);
rects=zeros([n 4]);
recti=[60,117,146,152];
rect_orig=recti;
rects(1,:)=recti;
width=abs(recti(1)-recti(3));
height=abs(recti(2)-recti(4));
for i=1:n-1
    if i==1 || i==100 || i==200 || i==300 || i==400
        figure
        imshow(im2double(frames(:,:,i)));
        str = sprintf('%f (%f seconds)',i,toc);
        title(str);
        hold on;
        rectangle('position',[recti(1) recti(2) width height],'EdgeColor','y');
        rectangle('position',[rect_orig(1) rect_orig(2) width height],'EdgeColor','g');
        %hold off;
        %pause(0.001);
        
    end
    
    [u,v]=LucasKanade(frames(:,:,i),frames(:,:,i+1),recti);
    p=[u;v];
    rectp=[recti(1)+u recti(2)+v recti(3)+u recti(4)+v];
    %warped image 1
    trans = rectp - rects(1,:);
    [x,y]=meshgrid(1:size(frames,2),1:size(frames,1));
    warp_im=interp2(im2double(frames(:,:,1)),x-trans(1),y-trans(2));
    [u_star,v_star]=LucasKanade(warp_im,frames(:,:,i+1),rectp);
    p_star=[u_star;v_star];
    rectp_st=[rectp(1)+u_star rectp(2)+v_star rectp(3)+u_star rectp(4)+v_star];
    %rectp_st=round(rectp_st);
    normdiff=norm(p-p_star);
    th=10;
    if normdiff<=th
        recti=rectp_st;
    else
        recti=rectp;
    end
    %end
    [u_orig,v_orig]=LucasKanade(frames(:,:,i),frames(:,:,i+1),rect_orig);
    rect_orig=[rect_orig(1)+u_orig rect_orig(2)+v_orig rect_orig(3)+u_orig rect_orig(4)+v_orig];
    rect_orig=round(rect_orig);
    
    rects(i+1,:)=recti;
end
% save the rects


 save(fullfile('..','results','carseqrects-wcrt.mat'), 'rects');

