im1=imread('../data/im1.png');
im2=imread('../data/im2.png');
load('../data/templeCoords.mat');
load('q2_1.mat');
load('q2_5.mat');
load('../data/intrinsics.mat');
M1=[eye(3,3),zeros(3,1)];
n_pts=size(x1,1);
x2=zeros(size(x1));
y2=zeros(size(y1));
for i=1:n_pts
    [x2(i),y2(i)]= epipolarCorrespondence( im1, im2, F, x1(i), y1(i));
end
pts1=[x1,y1];
pts2=[x2,y2];
P=triangulate(K1*M1, pts1, K2*M2, pts2);
scatter3(P(:,1),P(:,2),P(:,3));
save('q2_7.mat','F','M1','M2');