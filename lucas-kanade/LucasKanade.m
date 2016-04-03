%implemented inverse composition algorithm for faster output
function [u, v] = LucasKanade(It, It1, rect)
It=im2double(It);
It1=im2double(It1);
[xtemp,ytemp]=meshgrid(rect(1):rect(3),rect(2):rect(4));
temp=interp2(It,xtemp,ytemp);
%imshow(temp);
%temp=It(rect(2):rect(4),rect(1):rect(3));
[im_gradx,im_grady]=gradient(temp);
im_grad=double([im_gradx(:),im_grady(:)]);
u=0;
v=0;
p=[u;v];
%del_p=[u;v];
p_size=size(p,1);
jacob=eye(p_size);
sd_im=im_grad*jacob;
hess=sd_im'*sd_im;
%hess_inv=inv(hess);
th=0.01;
%for i=1:1000
while 1
    [xwarp,ywarp]=meshgrid((rect(1)+p(1)):(rect(3)+p(1)),(rect(2)+p(2)):(rect(4)+p(2)));
    warp_im=interp2(It1,xwarp,ywarp);
    
    %code to overcome size issues of interp2
    jugaad_im = zeros(size(temp));
    jugaad_im(1:min(size(warp_im,1),size(temp,1)), 1:min(size(warp_im,2),size(temp,2))) = warp_im(1:min(size(warp_im,1),size(temp,1)),1:min(size(warp_im,2),size(temp,2)));
    warp_im = jugaad_im;
    
    error_im=warp_im-temp;
    sd_update=(sd_im)'*error_im(:);
    del_p=hess\sd_update;
    p(1)=p(1)-del_p(1); %inverse warp comes out to be -tx*cosa-ty*sina
    p(2)=p(2)-del_p(2); %-ty*cosa+tx*sina
    u=p(1);
    v=p(2);
    if norm(del_p)<=th
        break;
    end
end
%end
end 
  




