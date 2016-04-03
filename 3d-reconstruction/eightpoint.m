function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup
F=[];
N=size(pts1,1);
%scale matrix
T=eye(3)/M;
T(3,3)=1;
p_im1=[pts1,ones(N,1)];
p_im1=(T*p_im1')';
p_im2=[pts2,ones(N,1)];
p_im2=(T*p_im2')';
A=[p_im2(:,1).*p_im1(:,1),p_im2(:,1).*p_im1(:,2),p_im2(:,1).*p_im1(:,3),p_im2(:,2).*p_im1(:,1),p_im2(:,2).*p_im1(:,2),p_im2(:,2).*p_im1(:,3),p_im2(:,3).*p_im1(:,1),p_im2(:,3).*p_im1(:,2),p_im2(:,3).*p_im1(:,3)];
%finding F through Eigen decomposition
[V,D] = eig(A'*A);
[~, ind] = min(diag(D));
f = V(:,ind);
F= reshape(f,3,3);
F=F';
%making F of rank 2
[FU,FS,FV]=svd(F);
FS(3,3)=0;
F=FU*FS*FV';
%refine
F=refineF(F,p_im1(:,1:2),p_im2(:,1:2));
%unscale
F=T'*F*T;
save('q2_1.mat','F','M','pts1','pts2');
end
