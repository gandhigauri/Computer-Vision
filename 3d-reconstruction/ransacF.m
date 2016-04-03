function [ F ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.X - Extra Credit:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using sevenpoint
%          - using ransac

%     In your writeup, describe your algorith, how you determined which
%     points are inliers, and any other optimizations you made

F=[];
N_corr=7;
nIter=100;
tol=0.01;
inliers_max=0;
total_corr=size(pts1,1);
for i=1:nIter
   num_inliers=0;
   random_pts = randi([1 total_corr],1,7);
   rand_pts1=pts1(random_pts,:);
   rand_pts2=pts2(random_pts,:);
   rand_F = sevenpoint(rand_pts1,rand_pts2,M);
   rand_F=real(rand_F);
   p_im1=[pts1,ones(total_corr,1)];
   p_im2=[pts2,ones(total_corr,1)];
   for pts=1:total_corr
       check=p_im2(pts,:)*rand_F*p_im1(pts,:)';
       if abs(check)<tol
           num_inliers=num_inliers+1;
       end
   end
   if num_inliers>inliers_max
       inliers_max=num_inliers;
       F=rand_F;
   end
   
end
disp(inliers_max);




end

