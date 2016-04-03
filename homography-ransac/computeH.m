 function H2to1 = computeH(p1,p2)
N=size(p1,2);
A=ones([2*N,9]);
p2=[p2(1,:);p2(2,:);ones([1,N])];
for pt=1:N
    A(2*pt-1,:)=[(p2(:,pt))' 0 0 0 -1*p1(1,pt)*p2(:,pt)'];
    A(2*pt,:)=[0 0 0 (p2(:,pt))' -1*p1(2,pt)*p2(:,pt)'];
end
[V,D] = eig(A'*A);
[~, ind] = min(diag(D));
h = V(:,ind);
H2to1= reshape(h,3,3);
H2to1=H2to1';
end
