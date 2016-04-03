function [locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast, th_r)
[GaussianPyramid] = createGaussianPyramid(im, sigma0, k, levels);
[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
PrincipalCurvature = computePrincipalCurvature(DoGPyramid);
locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r);
final_im=insertMarker(im,[locsDoG(:,1),locsDoG(:,2)],'size',1);
imshow(final_im);
end