function mask = SubtractDominantMotion(image1, image2)
image1=im2double(image1);
image2=im2double(image2);
mask=zeros(size(image1));
level=0.11;
M=LucasKanadeAffine(image1,image2);
[x,y]=meshgrid(1:size(image1,2),1:size(image1,1));
xwarp=M(1,1)*x+M(1,2)*y+M(1,3);
ywarp=M(2,1)*x+M(2,2)*y+M(2,3);
warp_im=interp2(image1,xwarp,ywarp);
img_diff=abs(image2-warp_im);
se=strel('disk',2); 
mask=imclearborder(im2bw(img_diff,level));
mask = bwareaopen(mask, 30);
mask=imdilate(mask,se);
mask=imerode(mask,se);
end
