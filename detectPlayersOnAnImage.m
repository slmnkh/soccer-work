function [ImgBB] = detectPlayersOnAnImage(Imrgb,jerseyColorPixels)

% cd(codePath);
%% Parameters
thArea = 50;
thJerseyColorDiff = 112;        % Initial value was kept as 105
thBottomPlayerPixels = 5;       % Percent of Player Background having player pixels in the bottom
thTotalPlayerPixels = 30;      % Percent of Player Background having player pixels in the total Bounding Box
bottomPercent = 50;             % Bottom percentage area of Player Background to be taken
lengthTopPercent = 20;
avgBBWidth = 15;
avgBBLength = 30;
avgBB = [avgBBWidth avgBBLength];
hsize = 25;
sigma = 5;
bboxRatio = 1/100;              % 

ImRevBin = removeFootballGround(Imrgb,bboxRatio);
%     ImRevBin = removeFootballGround(Imrgb);

% imshow(ImRevBin);

ImgBlobs = getBlobs(ImRevBin);

[ImgBB,avgBB] = identifyPlayersForFieldLines(ImgBlobs,Imrgb,1,thArea,thBottomPlayerPixels,thTotalPlayerPixels,thJerseyColorDiff,lengthTopPercent,jerseyColorPixels,avgBB, bottomPercent,0);

end
