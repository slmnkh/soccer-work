function [redTh,greenTh,blueTh]=histPeaks(Imrgb)

rHist = imhist(Imrgb(:,:,1), 256);
gHist = imhist(Imrgb(:,:,2), 256);
bHist = imhist(Imrgb(:,:,3), 256);

rHist(1) = 0;
gHist(1) = 0;
bHist(1) = 0;

%find distribution
mean(rHist);

Imnew = Imrgb;
redTh = find(rHist>max(rHist)-1);
greenTh = find(gHist>max(gHist)-1);
blueTh = find(bHist>max(bHist)-1);

end