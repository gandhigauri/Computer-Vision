function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareX, compareY)
pw=9;
p_lim=(pw-1)/2;
n=256;
im = im2double(im);
if size(im,3)==3
    im= rgb2gray(im);
end
locs=[];
desc=[];
for i=1:size(locsDoG,1)
    if locsDoG(i,1)>p_lim & locsDoG(i,1)<(size(im,2)-p_lim+1) & locsDoG(i,2)>p_lim & locsDoG(i,2)<(size(im,1)-p_lim+1)
        locs=cat(1,locs,locsDoG(i,:));       
    end
end

[row_x,col_x]=ind2sub(pw*size(pw),compareX);
X=[row_x,col_x];
[row_y,col_y]=ind2sub(pw*size(pw),compareY);
Y=[row_y,col_y];

for i=1:size(locs,1)
    patch=im(locs(i,2)-p_lim:locs(i,2)+p_lim,locs(i,1)-p_lim:locs(i,1)+p_lim);
    for j=1:n
        if patch(X(j,1),X(j,2))<patch(Y(j,1),Y(j,2))
            desc(i,j)=1;
        else
            desc(i,j)=0;
        end
    end
end
end