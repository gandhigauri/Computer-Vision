function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
bestH=[];
N=4;
total_p1=locs1(matches(:,1),1:2)';
total_p2=locs2(matches(:,2),1:2)';
total_corr=size(total_p1,2);
homo_pt1=[total_p1(1,:);total_p1(2,:);ones([1,total_corr])];
homo_pt2=[total_p2(1,:);total_p2(2,:);ones([1,total_corr])];
p1=zeros([2,N]);
p2=zeros([2,N]);
inliers_max=0;
for i=1:nIter
   num_inliers=0;
   random_pts = randi([1 total_corr],1,4);
   for j=1:N
       p1(:,j)=total_p1(:,random_pts(1,j));
       p2(:,j)=total_p2(:,random_pts(1,j));
   end
   H2to1 = computeH(p1,p2);
   p2_transformed=H2to1*homo_pt2;
   p2_transformed=p2_transformed./repmat(p2_transformed(3,:),3,1); %normalize
   dist=homo_pt1-p2_transformed;
   error=sqrt((dist(1,:).^2)+(dist(2,:).^2));
   for pts=1:total_corr
       if error(:,pts)<tol
           num_inliers=num_inliers+1;
       end
   end
   if num_inliers>inliers_max
       inliers_max=num_inliers;
       bestH=H2to1;
   end
   
end
disp(inliers_max);
end
