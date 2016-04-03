%implemented original Lucas Kanade algorithm as it was difficult to
%calculate inverse of affine warp for inverse compositional algorithm
function M = LucasKanadeAffine(It, It1)
It=im2double(It);
It1=im2double(It1);
temp=It;
p=zeros([6,1]);
[x,y]=meshgrid(1:size(It,2),1:size(It,1));
th=0.1;
while 1
     M(1,:)=[1+p(1) p(2) p(3)];
     M(2,:)=[p(4) 1+p(5) p(6)];
     M(3,:)=[0 0 1];  
    xwarp=M(1,1)*x+M(1,2)*y+M(1,3);
    ywarp=M(2,1)*x+M(2,2)*y+M(2,3);
    warp_im=interp2(It1,xwarp,ywarp);
%       tform= affine2d(M');
%       warp_im=imwarp(It1,tform,'OutputView', imref2d(size(It)));

     warp_im(isnan(warp_im)) = 0;
    mask = zeros(size(It,1), size(It,2));
    mask = mask | (xwarp >=1 & xwarp <= size(It,2));
    mask = mask & (ywarp >=1 & ywarp <= size(It,1));
    error_im=mask.*(temp-warp_im);
    [im_gradx,im_grady]=gradient(It1);
    warp_gradx=interp2(mask.*im_gradx,xwarp,ywarp);
    warp_grady=interp2(mask.*im_grady,xwarp,ywarp);
%     warp_gradx=imwarp(im_gradx,tform,'OutputView',imref2d(size(It)));
%     warp_grady=imwarp(im_grady,tform,'OutputView',imref2d(size(It)));
    warp_grad=double([warp_gradx(:),warp_grady(:)]);
    warp_grad(isnan(warp_grad)) = 0;
    %diff jacob for affine
    sd_im=[x(:).*warp_grad(:,1) y(:).*warp_grad(:,1) warp_grad(:,1) x(:).*warp_grad(:,2) y(:).*warp_grad(:,2) warp_grad(:,2)];
    hess=sd_im'*sd_im;
    sd_update=(sd_im)'*error_im(:);
    del_p=hess\sd_update;
    p=p+del_p;
%     M(1,:)=[p(1) p(2) p(3)];
%     M(2,:)=[p(4) p(5) p(6)];
%     M(3,:)=[0 0 1];
    if norm(del_p)<=th
        break;
    end
end
end

