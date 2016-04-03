function [panoImg] = imageStitching(img1, img2, H2to1)
img1=im2double(img1);
img2=im2double(img2);
save('../results/q5_1.mat','H2to1');
panoImg=[];
I=[1 0 0;0 1 0;0 0 1];
out_size=[693 1280];
%mask1
mask1 = zeros(size(img1)); 
mask1(1,:,:) = 1; mask1(end,:,:) = 1; mask1(:,1,:) = 1; mask1(:,end,:) = 1; 
mask1 = bwdist(mask1,'city'); 
mask1 = mask1/max(mask1(:));
warp_mask1=warpH(mask1,I,out_size);
%mask2
mask2 = zeros(size(img2)); 
mask2(1,:,:) = 1; mask2(end,:,:) = 1; mask2(:,1,:) = 1; mask2(:,end,:) = 1; 
mask2 = bwdist(mask2,'city'); 
mask2 = mask2/max(mask2(:));
warp_mask2=warpH(mask2,H2to1,out_size);
%images
warp_im1=warpH(img1,I,out_size);
warp_im2= warpH(img2,H2to1,out_size);
figure
imshow(warp_im2);
imwrite(warp_im2,'../results/q5_1.jpg');
img_mask1= warp_im1.*warp_mask1;
img_mask2= warp_im2.*warp_mask2;
total=warp_mask1+warp_mask2;
panoImg=(img_mask1+img_mask2)./total;
figure
imshow(panoImg);
end