function [histInter] = distanceToSet(wordHist, histograms)
min_dist = bsxfun(@min, wordHist, histograms);
histInter=sum(min_dist);
end
