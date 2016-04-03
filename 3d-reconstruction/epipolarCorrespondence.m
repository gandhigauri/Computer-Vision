function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q2.6 - Todo:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q2_6.mat
%
%           Explain your methods and optimization in your writeup
im1=im2double(rgb2gray(im1));
im2=im2double(rgb2gray(im2));
p1=[x1;y1;1];
epipolar_line=F*p1;
a=epipolar_line(1);
b=epipolar_line(2);
c=epipolar_line(3);
window1 = im1(y1-5:y1+5,x1-5:x1+5);
n=100;
error=zeros([n,1]);
for i=1:n     
    y2_test=y1-(n/2)+i;
    x2_test=round((-c-(b*y2_test))/a);
    window2 = im2(y2_test-5:y2_test+5, x2_test-5:x2_test+5);
    diff=imabsdiff(window1,window2);
    error(i,1)=sum(diff(:));
end
[~,ind]=min(error);
y2=y1-(n/2)+ind;
x2=round((-c-(b*y2))/a);
end

