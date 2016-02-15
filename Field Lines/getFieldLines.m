function [Ican2] = getFieldLines(Imrgb)

% logoPts = [109.2598   48.3995;
%     115.7904   37.3477;
%     206.2143   37.3477;
%     214.7543   48.3995;
%     223.7967   48.9019;
%     219.2755   62.9678;
%     106.2457   64.9772;
%     99.2127   49.4042];
% 
% fill(logoPts(:,1),logoPts(:,2),'r')

% Imrgb = imread('C:\Studies\UCF\FootballResearch\Dataset\Vid1\Segmented Image Sequence\Vid1Seq12\Vid1_Img_016985.bmp');
% im = imread('C:\Studies\UCF\FootballResearch\Dataset\Vid1\Segmented Image Sequence\Vid1Seq12\Vid1_Img_017214.bmp');

% codePath = 'C:\Studies\UCF\FootballResearch\Mac Code';
% cd(codePath)
shrinkLen = 17;
percentArea = 70;
ImRevBin = removeFootballGroundForFieldLines(Imrgb,shrinkLen);

% imshow(ImRevBin);

[Igrad Ior] = canny(ImRevBin,0.5);
[im,location] = nonmaxsup(Igrad, Ior, 1.2);     % Put radius values between 1.2-1.5
Ican = im2bw(im,0);

% Remove the logo
Ican(37:66,100:225) = 0;
Ican(304:338,546:624) = 0;
% imshow(Ican)

% Remove Players
load Vid1_jerseyColors.mat
% cd(codePath)
ImBB = detectPlayersOnAnImage(Imrgb,jerseyColorPixels);

for i=1:size(ImBB,1)
   Ican(ImBB(i,2):(ImBB(i,2)+ImBB(i,4)),ImBB(i,1):(ImBB(i,1)+ImBB(i,3))) = 0;
end

Ican2 = bwareaopen(Ican,80);
imshow(Ican2)
end