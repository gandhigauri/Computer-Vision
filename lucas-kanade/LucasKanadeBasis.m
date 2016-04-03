%implemented simultaneous inverse compositional algrithm as the other two
%were difficult to implement
function [u, v] = LucasKanadeBasis(It, It1, rect, basis)
It=im2double(It);
It1=im2double(It1);

[xtemp,ytemp]=meshgrid(rect(1):rect(3),rect(2):rect(4));
temp=interp2(It,xtemp,ytemp);
[im_gradx,im_grady]=gradient(temp);
im_grad=double([im_gradx(:),im_grady(:)]);

bas_grad=zeros(size(basis,1)*size(basis,2),2,size(basis,3));
for i=1:size(basis,3)
    [bas_gradx,bas_grady]=gradient(basis(:,:,i));
    bas_grad(:,:,i)=double([bas_gradx(:),bas_grady(:)]);
end
w=zeros(size(basis,3),1);
u=0;
v=0;
p=[u;v];
p_size=size(p,1);
jacob=eye(p_size);
th=0.01;

while 1
    [xwarp,ywarp]=meshgrid((rect(1)+p(1)):(rect(3)+p(1)),(rect(2)+p(2)):(rect(4)+p(2)));
    warp_im=interp2(It1,xwarp,ywarp);
    % calculating weighted sum
    wt_sum=0;
    for i=1:size(basis,3)
        wt_sum=wt_sum+w(i)*basis(:,:,i);
    end
    error_im=temp-warp_im+wt_sum;
    sum_grad_bas=0;
    for i=1:size(basis,3)
        sum_grad_bas=sum_grad_bas+w(i)*bas_grad(:,:,i);
    end
    sd_sum=im_grad+sum_grad_bas;
    sd_im=[sd_sum*jacob,reshape(basis,[size(basis,1)*size(basis,2),size(basis,3)])];
    hess=sd_im'*sd_im; 
    sd_update=(sd_im)'*error_im(:);
    del_q=-1*hess\sd_update;
    p(1)=p(1)-del_q(1); %inverse warp comes out to be -tx*cosa-ty*sina
    p(2)=p(2)-del_q(2);%-ty*cosa+tx*sina
    u=p(1);
    v=p(2);
    w=w+del_q(3:end);
    if norm(del_q(1:2))<=th
        break;
    end
end
end

