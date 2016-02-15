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

% Imrgb = imread('F:\MyStuff\Research\Dataset\Vid1\Segmented Image Sequence\Vid1Seq2\Vid1Seq1_000099.jpeg');
% codePath = 'C:\Studies\UCF\FootballResearch\Mac Code';
% cd(codePath)
ImRevBin = removeFootballGroundForFieldLines(Imrgb);
% Remove the logo
ImRevBin(38:64,101:224) = 0;
% figure,imshow(ImRevBin);

Ican=canny(ImRevBin,0.5);
Ican = im2bw(Ican,0.1);
% imshow(Ican)
Ican2 = imfill(Ican,'holes');

Ican2 = bwareaopen(Ican2,1000);
% imshow(Ican2)
% imshow(ImRevBin);

Ican2 = Ican2 .* Ican;
% imshow(Ican2)
Ican2 = bwareaopen(Ican2,1000);
% imshow(Ican2)


end