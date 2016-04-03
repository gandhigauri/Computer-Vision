function [compareX, compareY] = makeTestPattern(patchWidth, nbits)
gauss_mean=(patchWidth+1)/2;
gauss_sd=patchWidth/5;
x=round(normrnd(gauss_mean,gauss_sd,[nbits 2]));
x(x<1)=1;
x(x>9)=9;
compareX=sub2ind(patchWidth*size(patchWidth),x(:,1),x(:,2));
y=round(normrnd(gauss_mean,gauss_sd,[nbits 2]));
y(y<1)=1;
y(y>9)=9;
compareY=sub2ind(patchWidth*size(patchWidth),y(:,1),y(:,2));
save('../results/testPattern.mat','compareX','compareY')
end