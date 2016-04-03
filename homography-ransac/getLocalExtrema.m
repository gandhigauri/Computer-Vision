function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r)
regmax = imregionalmax(DoGPyramid,26);
regmin = imregionalmin(DoGPyramid,26);
locsDoG=[];
n=1;
for l=1:size(DoGPyramid,3)
    for x=1:size(DoGPyramid,2)
        for y=1:size(DoGPyramid,1)
            if (regmax(y,x,l)==1 | regmin(y,x,1)==1) & DoGPyramid(y,x,l)>th_contrast & PrincipalCurvature(y,x,1)<th_r
                locsDoG(n,1)=x;
                locsDoG(n,2)=y;
                locsDoG(n,3)=DoGLevels(l);
                n=n+1;
            end
            
        end
    end
end
                
end