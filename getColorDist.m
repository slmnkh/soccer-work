function [redMean,redStd,greenMean,greenStd,blueMean,blueStd] = getColorDist(Imrgb)

%rgbhist(Imrgb);     %shows peaks
%figure, imshow(Imrgb)

[redTh,greenTh,blueTh] = histPeaks(Imrgb);

%% To show the color of the histogram peaks
Imnew=Imrgb;
Imnew(:,:,1) = redTh(1);
Imnew(:,:,2) = greenTh(1);
Imnew(:,:,3) = blueTh(1);
%figure, imshow(Imnew);

%% Using distribution of colors given by histogram  to calculate mean and std
%% for RGB and then threshold colors that lie outside one standard deviation
%% of peak

redDist = reshape(im2double(Imrgb(:,:,1)),size(Imrgb,1)*size(Imrgb,2),1);
redMean = mean(redDist*255); redStd = std(redDist*255);

greenDist = reshape(im2double(Imrgb(:,:,2)),size(Imrgb,1)*size(Imrgb,2),1);
greenMean = mean(greenDist*255); greenStd = std(greenDist*255);

blueDist = reshape(im2double(Imrgb(:,:,3)),size(Imrgb,1)*size(Imrgb,2),1);
blueMean = mean(blueDist*255); blueStd = std(blueDist*255);

end