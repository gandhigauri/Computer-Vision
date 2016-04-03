im=imread('../data/model_chickenbroth.jpg');
im = im2double(im);
if size(im,3)==3
    im= rgb2gray(im);
end
match_mat=zeros([1,36]);
for i=1:36
    im_rot=imrotate(im,10*i);
    [locs1, desc1] = briefLite(im);
    [locs2, desc2] = briefLite(im_rot);
    [matches] = briefMatch(desc1, desc2);
    match_mat(1,i)=size(matches,1);
end
bar(10:10:360,match_mat);
    