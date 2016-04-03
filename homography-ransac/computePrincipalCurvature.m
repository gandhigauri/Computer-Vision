function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
PrincipalCurvature=zeros(size(DoGPyramid));
for l=1:size(DoGPyramid,3)
    [dx,dy]=gradient(DoGPyramid(:,:,l));
    [dxx,dxy]=gradient(dx);
    [dyx,dyy]=gradient(dy);
    for i=1:size(DoGPyramid,1)
        for j=1:size(DoGPyramid,2)
            H=[dxx(i,j) dxy(i,j);dyx(i,j) dyy(i,j)];
            PrincipalCurvature(i,j,l)=(trace(H)^2)/det(H);
        end
    end
end
end