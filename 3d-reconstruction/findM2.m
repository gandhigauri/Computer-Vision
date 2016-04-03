% Q2.5 - Todo:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       4. Save the correct M2, p1, p2, R and P to q2_5.mat
I1=imread('../data/im1.png');
I2=imread('../data/im2.png');
load('../data/some_corresp.mat');
load('../data/intrinsics.mat');
M=max(size(I1));
F=eightpoint(pts1,pts2,M);
E=essentialMatrix(F,K1,K2);
M1=[eye(3,3),zeros(3,1)];
M2s=camera2(E);
for i=1:4
    P=triangulate(K1*M1, pts1, K2*M2s(:,:,i), pts2);
    if all(P(:,3)>0)
        Pbest=P;
        M2=M2s(:,:,i);
    end
end
p1=pts1;
p2=pts2;
P=Pbest;
save('q2_5.mat','M2','p1','p2','P');