function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)
DoGPyramid=zeros([size(GaussianPyramid,1) size(GaussianPyramid,2) length(levels)-1]);
DoGLevels=zeros([length(levels)-1 1]);
i=0;
for i=1:length(levels)-1
    DoGPyramid(:,:,i)=GaussianPyramid(:,:,i+1)-GaussianPyramid(:,:,i);
    DoGLevels(i)=levels(i+1);
end
end