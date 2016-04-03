function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
out_width=1280;
%corners
img1_corners=[1 1 1;size(img1,1) 1 1;1 size(img1,2) 1;size(img1,1) size(img1,2) 1]';
img2_corners=[1 1 1;size(img2,1) 1 1;1 size(img2,2) 1;size(img2,1) size(img2,2) 1]';
img2_tc=H2to1*img2_corners;
img2_tc=img2_tc./repmat(img2_tc(3,:),3,1);
w1=abs(pdist([img2_tc(:,3)';img1_corners(:,1)'],'euclidean'));
w2=abs(pdist([img2_tc(:,4)';img1_corners(:,2)'],'euclidean'));
width=max(w1,w2);
h1=abs(pdist([img2_tc(:,3)';img2_tc(:,4)'],'euclidean'));
h2=abs(pdist([img2_tc(:,1)';img2_tc(:,2)'],'euclidean'));
h3=abs(pdist([img1_corners(:,1)';img1_corners(:,2)'],'euclidean'));
height=max(max(h1,h2),h3);
a_r=width/height;
out_height=round(out_width/a_r);

X=[img1_corners(1,:) img2_tc(1,:)];
Xmax=max(X(:));
Xmin= min(X(:));
Y=[img1_corners(2,:) img2_tc(2,:)];
Ymax= max(Y(:));
Ymin= min(Y(:));


%out_size = [size(img2,1) size(img2,2)];
tx=(Ymax+Ymin)/2;
ty=(Xmax+Xmin)/2;
M=[1 0 tx;0 1 ty;0 0 a_r];
out_size=[out_height out_width];
%out_size=[round(height) round(width)];
img1=im2double(img1);
img2=im2double(img2);
%mask1
mask1 = zeros(size(img1)); 
mask1(1,:,:) = 1; mask1(end,:,:) = 1; mask1(:,1,:) = 1; mask1(:,end,:) = 1; 
mask1 = bwdist(mask1,'city'); 
mask1 = mask1/max(mask1(:));
warp_mask1=warpH(mask1,M,out_size);
%mask2
mask2 = zeros(size(img2)); 
mask2(1,:,:) = 1; mask2(end,:,:) = 1; mask2(:,1,:) = 1; mask2(:,end,:) = 1; 
mask2 = bwdist(mask2,'city'); 
mask2 = mask2/max(mask2(:));
warp_mask2=warpH(mask2,M*H2to1,out_size);
%images
warp_im1=warpH(img1,M,out_size);
warp_im2= warpH(img2,M*H2to1,out_size);
img_mask1= warp_im1.*warp_mask1;
img_mask2= warp_im2.*warp_mask2;
total=warp_mask1+warp_mask2;
panoImg=(img_mask1+img_mask2)./total;
%imshow(panoImg);
end