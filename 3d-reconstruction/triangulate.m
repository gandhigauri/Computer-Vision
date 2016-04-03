function [ P, error ] = triangulate( M1, p1, M2, p2 )
% triangulate:
%       M1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       M2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

% Q2.4 - Todo:
%       Implement a triangulation algorithm to compute the 3d locations
%       See Szeliski Chapter 7 for ideas
%

N=size(p1,1);
P=zeros([N,3]);
error=0;
for i=1:N
    A=[p1(i,1)*M1(3,:)-M1(1,:);p1(i,2)*M1(3,:)-M1(2,:);p2(i,1)*M2(3,:)-M2(1,:);p2(i,2)*M2(3,:)-M2(2,:)];
    [V,D] = eig(A'*A);
    [~, ind] = min(diag(D));
    pt_world = V(:,ind);
    pt_world=pt_world';
    pt_world=pt_world./pt_world(4);
    P(i,:)=pt_world(1,1:3);
    p_est1=M1*pt_world';
    p_est2=M2*pt_world';
    error=error+(pdist2(p1(i,:),p_est1(1:2,1)'))^2 + (pdist2(p2(i,:),p_est2(1:2,1)'))^2;
end
end

