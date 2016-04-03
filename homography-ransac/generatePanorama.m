function im3 = generatePanorama(im1, im2)
im1 = im2double(im1);
if size(im1,3)==3
    im_grey1= rgb2gray(im1);
end
im2 = im2double(im2);
if size(im2,3)==3
    im_grey2= rgb2gray(im2);
end
[locs1, desc1] = briefLite(im_grey1);
[locs2, desc2] = briefLite(im_grey2);
ratio=1;
[matches] = briefMatch(desc1, desc2);
%plotMatches(im1, im2, matches, locs1,  locs2);
nIter=1000;
tol=10;
bestH = ransacH(matches, locs1, locs2, nIter, tol);
H2to1=bestH;
im3 = imageStitching_noClip(im1, im2, H2to1);
imshow(im3);
end